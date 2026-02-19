/*
 * expscan.re - Direct re2c scanner for the EXPRESS language.
 *
 * This file is the direct re2c source for the EXPRESS lexical analyser.
 * It replaces the old expscan.l (perplex/flex format) and is compiled
 * directly by re2c to produce expscan.c, eliminating the need for perplex.
 *
 * Run:
 *   re2c --no-debug-info --no-generation-date -c \
 *        -Wno-condition-order -o expscan.c expscan.re
 *
 * Original scanner by U.S. Government employees; not subject to copyright.
 */

#include <ctype.h>
#if !defined(isascii) && defined(__isascii)
#  define isascii __isascii
#endif
#include "express/basic.h"
#include "express/error.h"
#include "express/lexact.h"
#include "express/express.h"
#include "expparse.h"
#include "expscan.h"

/* yylineno is maintained by NEWLINE macro; yyeof unused but referenced */
extern int  yylineno;
extern bool yyeof;

/* Nesting depth for (* ... *) comments */
static int nesting_level = 0;

/* can't imagine this will ever be more than 2 or 3 - DEL */
#define MAX_NESTED_COMMENTS 20
static struct Symbol_ open_comment[MAX_NESTED_COMMENTS];

/* Current filename (kept in sync with SCANbuffer by SCAN_lex_init) */
extern const char *current_filename;

/* -----------------------------------------------------------------------
 * re2c configuration macros
 * All macros use `scanner` as the variable name for the perplex_t argument.
 * --------------------------------------------------------------------- */

#define YYCTYPE           char
#define YYCURSOR          (scanner->cursor)
#define YYMARKER          (scanner->marker)
#define YYLIMIT           (scanner->null)
#define YYFILL(n)         bufferFill(scanner, (n))
#define YYGETCONDITION()  (scanner->cond)
#define YYSETCONDITION(c) (scanner->cond = (c))

/* Increment line counter */
#define NEWLINE  (yylineno++)

/* When lex looks ahead over a newline, error messages get thrown off.
 * Fortunately we know when that occurs, so adjust for it. */
#define LINENO_FUDGE  (yylineno - 1)

/* Token-start management: must be bare statements so that `continue` below
 * reaches the outer while(1) loop and is not trapped by any do-while. */
#define UPDATE_START   (scanner->tok = scanner->cursor)

/* Skip a token and restart the scanner loop.
 * Note: NO do-while wrapper; `continue` must reach the outer while(1). */
#define IGNORE_TOKEN   UPDATE_START; continue

/* Get null-terminated copy of current token text */
#define yytext  getTokenText(scanner)

/* -----------------------------------------------------------------------
 * SCAN_lex_init - (Re-)initialise scanner state for a new file.
 * --------------------------------------------------------------------- */
void
SCAN_lex_init(char *filename, FILE *fp)
{
    /* Return to initial scan buffer */
    SCAN_current_buffer = 0;
    *(SCANcurrent = SCANbuffer.text) = '\0';
    SCANbuffer.readEof = false;
    SCANbuffer.file = fp;
    SCANbuffer.filename = (filename ? filename : "");
    current_filename = SCANbuffer.filename;
}

/* -----------------------------------------------------------------------
 * Private inner scanner - contains the re2c generated state machine.
 *
 * NOTE: No <*> rules are used here because they conflict with the empty-
 * string <INITIAL> transition.  Common rules (whitespace, "(*") are
 * written separately per condition.
 *
 * NOTE: IGNORE_TOKEN must NOT be wrapped in do-while; the bare `continue`
 * must reach the outer while(1) loop directly.
 * --------------------------------------------------------------------- */
static int
yylex_private(perplex_t scanner)
{
    while (1) {
        /* Check for end of input */
        if (scanner->atEOI && scanner->cursor >= scanner->null) {
            return YYEOF;
        }

        /* Reset token start for each new token */
        scanner->tok = scanner->cursor;

        /*!re2c
        re2c:yyfill:enable = 1;

        digit    = [0-9];
        integer  = digit+;
        letter   = [A-Za-z];
        id_char  = [A-Za-z0-9_];

        /* ================================================================
         * INITIAL state: immediately bootstrap into code.
         * No other rules in this condition so the "" match is unambiguous.
         * ============================================================== */
        <INITIAL>  "" => code { continue; }

        /* ================================================================
         * Rules for <code> condition
         * ============================================================== */

        /* Whitespace */
        <code>  [ \t]+  { IGNORE_TOKEN; }

        /* Newline */
        <code>  "\n"    { NEWLINE; IGNORE_TOKEN; }

        /* Line comment */
        <code>  "--" [^\n]* "\n"  {
            NEWLINE;
            SCANsave_comment(yytext);
            IGNORE_TOKEN;
        }

        /* Open nested comment */
        <code>  "(*"  => comment  {
            if (nesting_level < MAX_NESTED_COMMENTS) {
                open_comment[nesting_level].line     = yylineno;
                open_comment[nesting_level].filename = current_filename;
            }
            nesting_level++;
            IGNORE_TOKEN;
        }

        /* Real literal (e.g. 3.14, 1.0e-5) */
        <code>  integer "." integer? ([eE] [+-]? integer)?  {
            return SCANprocess_real_literal(yytext);
        }

        /* Integer literal */
        <code>  integer  {
            return SCANprocess_integer_literal(yytext);
        }

        /* Binary literal  %01... */
        <code>  "%" [01]+  {
            return SCANprocess_binary_literal(yytext);
        }

        /* Identifier or keyword (letter-starting) */
        <code>  letter id_char*  {
            return SCANprocess_identifier_or_keyword(yytext);
        }

        /* Bad identifier (underscore-starting - not valid in EXPRESS) */
        <code>  [_] id_char*  {
            ERRORreport_with_line(BAD_IDENTIFIER, yylineno, yytext);
            return SCANprocess_identifier_or_keyword(yytext);
        }

        /* String literal (single-quoted; '' is an escaped quote) */
        <code>  ['] ([^'\n] | "''")*  [']  {
            return SCANprocess_string(yytext);
        }

        /* Unterminated string literal */
        <code>  ['] ([^'\n] | "''")*  "\n"  {
            ERRORreport_with_line(UNTERMINATED_STRING, LINENO_FUDGE);
            NEWLINE;
            return SCANprocess_string(yytext);
        }

        /* Encoded string literal (double-quoted) */
        <code>  ["] [^"\n]*  ["]  {
            return SCANprocess_encoded_string(yytext);
        }

        /* Unterminated encoded string */
        <code>  ["] [^"\n]*  "\n"  {
            ERRORreport_with_line(UNTERMINATED_STRING, LINENO_FUDGE);
            NEWLINE;
            return SCANprocess_encoded_string(yytext);
        }

        /* Semicolon followed by inline comment */
        <code>  ";" [ \t]* "--" [^\n]* "\n"  {
            NEWLINE;
            return SCANprocess_semicolon(yytext, 1);
        }

        /* Operators and punctuation */
        <code>  ";"   { return SCANprocess_semicolon(yytext, 0); }
        <code>  ":="  { return TOK_ASSIGNMENT; }
        <code>  ":"   { return TOK_COLON; }
        <code>  ","   { return TOK_COMMA; }
        <code>  "||"  { return TOK_CONCAT_OP; }
        <code>  "."   { return TOK_DOT; }
        <code>  "="   { return TOK_EQUAL; }
        <code>  "**"  { return TOK_EXP; }
        <code>  "|"   { return TOK_SUCH_THAT; }
        <code>  "<*"  { return TOK_ALL_IN; }
        <code>  ">="  { return TOK_GREATER_EQUAL; }
        <code>  ">"   { return TOK_GREATER_THAN; }
        <code>  "?"   { return TOK_QUESTION_MARK; }
        <code>  ":=:" { return TOK_INST_EQUAL; }
        <code>  ":<>:"{ return TOK_INST_NOT_EQUAL; }
        <code>  "["   { return TOK_LEFT_BRACKET; }
        <code>  "{"   { return TOK_LEFT_CURL; }
        <code>  "("   { return TOK_LEFT_PAREN; }
        <code>  "<="  { return TOK_LESS_EQUAL; }
        <code>  "<"   { return TOK_LESS_THAN; }
        <code>  "-"   { return TOK_MINUS; }
        <code>  "<>"  { return TOK_NOT_EQUAL; }
        <code>  "+"   { return TOK_PLUS; }
        <code>  "/"   { return TOK_REAL_DIV; }
        <code>  "]"   { return TOK_RIGHT_BRACKET; }
        <code>  "}"   { return TOK_RIGHT_CURL; }
        <code>  ")"   { return TOK_RIGHT_PAREN; }
        <code>  "*"   { return TOK_TIMES; }
        <code>  "\\"  { return TOK_BACKSLASH; }

        /* Unexpected but recognized characters */
        <code>  [$&@^~]  {
            ERRORreport_with_line(UNEXPECTED_CHARACTER, yylineno, yytext[0]);
            IGNORE_TOKEN;
        }

        /* Unmatched close comment in code */
        <code>  "*)"  {
            ERRORreport_with_line(UNMATCHED_CLOSE_COMMENT, yylineno);
            IGNORE_TOKEN;
        }

        /* Catch-all for unrecognised characters in code */
        <code>  [^]  { IGNORE_TOKEN; }

        /* ================================================================
         * Rules for <return_end_schema> condition
         * ============================================================== */

        /* Whitespace */
        <return_end_schema>  [ \t]+  { IGNORE_TOKEN; }

        /* Newline */
        <return_end_schema>  "\n"  { NEWLINE; IGNORE_TOKEN; }

        /* Open nested comment */
        <return_end_schema>  "(*"  => comment  {
            if (nesting_level < MAX_NESTED_COMMENTS) {
                open_comment[nesting_level].line     = yylineno;
                open_comment[nesting_level].filename = current_filename;
            }
            nesting_level++;
            IGNORE_TOKEN;
        }

        /* Sentinel 'X' injected by SCANskip_to_end_schema */
        <return_end_schema>  "X"  => code  {
            return TOK_END_SCHEMA;
        }

        /* Catch-all for return_end_schema */
        <return_end_schema>  [^]  { IGNORE_TOKEN; }

        /* ================================================================
         * Rules for <comment> condition
         * ============================================================== */

        /* Whitespace */
        <comment>  [ \t]+  { IGNORE_TOKEN; }

        /* Newline inside comment */
        <comment>  "\n"  { NEWLINE; IGNORE_TOKEN; }

        /* Open nested comment */
        <comment>  "(*"  => comment  {
            if (nesting_level < MAX_NESTED_COMMENTS) {
                open_comment[nesting_level].line     = yylineno;
                open_comment[nesting_level].filename = current_filename;
            }
            nesting_level++;
            IGNORE_TOKEN;
        }

        /* Close comment - may de-nest */
        <comment>  "*)"  {
            if (0 == --nesting_level) {
                YYSETCONDITION(yyccode);
            }
            IGNORE_TOKEN;
        }

        /* Non-special characters inside comment */
        <comment>  [^*()\n \t]+  { IGNORE_TOKEN; }
        <comment>  [*()]         { IGNORE_TOKEN; }

        /* Catch-all for comment */
        <comment>  [^]  { IGNORE_TOKEN; }

        */
    }
}

/* -----------------------------------------------------------------------
 * Public lexer entry point
 * --------------------------------------------------------------------- */
int
yylex(perplex_t scanner)
{
    int ret;

    scanner->tok = scanner->cursor;

    if (scanner->tokenText != NULL) {
        free(scanner->tokenText);
        scanner->tokenText = NULL;
    }

    ret = yylex_private(scanner);

    if (scanner->tokenText != NULL) {
        free(scanner->tokenText);
        scanner->tokenText = NULL;
    }

    return ret;
}

/* -----------------------------------------------------------------------
 * SCANskip_to_end_schema - Consume tokens up to and including END_SCHEMA.
 *
 * Used when a schema-level syntax error occurs and we want to resync.
 * After this call, the next yylex call returns TOK_END_SCHEMA.
 * --------------------------------------------------------------------- */
void
SCANskip_to_end_schema(perplex_t scanner)
{
    while (yylex(scanner) != TOK_END_SCHEMA) {
        /* keep consuming */
    }

    /* Inject a sentinel character so the next yylex can return
     * TOK_END_SCHEMA again (the parser needs it). */
    perplexUnput(scanner, 'X');
    YYSETCONDITION(yycreturn_end_schema);
}

/* -----------------------------------------------------------------------
 * Public scanner API - implementations of perplex-compatible functions.
 * Implemented here (not as static inline in the header) so they can be
 * mocked in unit tests with frameworks like FFF.
 * --------------------------------------------------------------------- */

perplex_t
perplexFileScanner(FILE *input)
{
    perplex_t scanner = (perplex_t)calloc(1, sizeof(struct re2c_scanner));

    scanner->inFile    = input;
    scanner->bufsize   = RE2C_BUF_INITIAL;
    scanner->buf       = (char *)malloc(scanner->bufsize);
    scanner->buf[0]    = '\0';
    scanner->cursor    = scanner->buf;
    scanner->marker    = scanner->buf;
    scanner->tok       = scanner->buf;
    scanner->null      = scanner->buf;
    scanner->atEOI     = 0;
    scanner->cond      = yyccode; /* start scanning immediately in code state */
    scanner->tokenText = NULL;
    return scanner;
}

perplex_t
perplexStringScanner(char *firstChar, size_t numChars)
{
    perplex_t scanner = (perplex_t)calloc(1, sizeof(struct re2c_scanner));

    scanner->inFile    = NULL;
    scanner->bufsize   = numChars + 1;
    scanner->buf       = (char *)malloc(scanner->bufsize);
    memcpy(scanner->buf, firstChar, numChars);
    scanner->buf[numChars] = '\0';
    scanner->cursor    = scanner->buf;
    scanner->marker    = scanner->buf;
    scanner->tok       = scanner->buf;
    scanner->null      = scanner->buf + numChars;
    scanner->atEOI     = 1;
    scanner->cond      = yyccode;
    scanner->tokenText = NULL;
    return scanner;
}

void
perplexFree(perplex_t scanner)
{
    if (scanner == NULL) {
        return;
    }
    free(scanner->buf);
    free(scanner->tokenText);
    free(scanner);
}

void
perplexUnput(perplex_t scanner, char c)
{
    size_t tok_off;
    size_t cursor_off;
    size_t marker_off;
    size_t null_off;
    size_t used;

    tok_off    = (size_t)(scanner->tok    - scanner->buf);
    cursor_off = (size_t)(scanner->cursor - scanner->buf);
    marker_off = (size_t)(scanner->marker - scanner->buf);
    null_off   = (size_t)(scanner->null   - scanner->buf);

    used = null_off + 1; /* includes null terminator */

    /* Grow buffer if needed */
    if (used + 1 > scanner->bufsize) {
        scanner->bufsize *= 2;
        scanner->buf = (char *)realloc(scanner->buf, scanner->bufsize);
        scanner->tok    = scanner->buf + tok_off;
        scanner->cursor = scanner->buf + cursor_off;
        scanner->marker = scanner->buf + marker_off;
        scanner->null   = scanner->buf + null_off;
    }

    /* Shift content from cursor onward right by one to make room */
    memmove(scanner->cursor + 1, scanner->cursor,
            (size_t)(scanner->null - scanner->cursor) + 1);

    /* Insert c at cursor position; cursor stays pointing to c */
    *scanner->cursor = c;
    scanner->null++;
}

void
perplexSetExtra(perplex_t scanner, void *extra)
{
    scanner->extra = extra;
}

void *
perplexGetExtra(perplex_t scanner)
{
    return scanner->extra;
}
