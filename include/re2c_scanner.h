/*
 * re2c_scanner.h - Reusable buffer management for direct re2c scanners
 *
 * This header-only library provides the scanner struct definition and
 * the static inline buffer management helpers that are called directly
 * from re2c-generated code via the YYFILL and yytext macros.
 *
 * The public perplex-compatible API (perplexFileScanner, perplexFree, etc.)
 * is declared in expscan.h and implemented in expscan.c so that unit tests
 * can mock those functions with frameworks like FFF.
 *
 * Usage:
 *   #include "re2c_scanner.h"  (included by expscan.h)
 *
 * In the re2c scanner source file, define the re2c macros to point to the
 * appropriate fields of the scanner struct:
 *
 *   #define YYCTYPE   char
 *   #define YYCURSOR  (scanner->cursor)
 *   #define YYMARKER  (scanner->marker)
 *   #define YYLIMIT   (scanner->null)
 *   #define YYFILL(n) bufferFill(scanner, n)
 *   #define YYGETCONDITION()  (scanner->cond)
 *   #define YYSETCONDITION(c) (scanner->cond = (c))
 */

#ifndef RE2C_SCANNER_H
#define RE2C_SCANNER_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Sentinel / EOF value returned by the scanner */
#ifndef YYEOF
#  define YYEOF (-1)
#endif

/* Initial buffer size and number of bytes read per YYFILL call */
#define RE2C_BUF_INITIAL  4096
#define RE2C_FILL_BLOCK   512

/* Forward declaration and typedef */
struct re2c_scanner;
typedef struct re2c_scanner *perplex_t;

/* Scanner state structure */
struct re2c_scanner {
    void   *extra;       /* application data */
    FILE   *inFile;      /* input file (NULL for string input) */
    char   *buf;         /* allocated input buffer */
    size_t  bufsize;     /* total capacity of buf */
    char   *cursor;      /* YYCURSOR - current scan position */
    char   *marker;      /* YYMARKER - backtracking position */
    char   *null;        /* YYLIMIT - points to the null terminator */
    char   *tok;         /* start of current token */
    char   *tokenText;   /* extracted token text (heap-allocated copy) */
    int     atEOI;       /* 1 when no more input is available from inFile */
    int     cond;        /* current scanner condition (YYCONDTYPE) */
};

/*
 * bufferFill - Read more input into the scanner buffer.
 *
 * Called by the YYFILL(n) macro when re2c needs more input.
 * Shifts existing in-use content to the beginning of the buffer,
 * grows the buffer if needed, then reads RE2C_FILL_BLOCK bytes.
 */
static inline void
bufferFill(perplex_t scanner, size_t n)
{
    char   *shift_from;
    size_t  shift_amount;
    size_t  keep_bytes;
    size_t  null_off;
    size_t  nread;

    if (scanner->atEOI || scanner->inFile == NULL) {
        return;
    }

    /* Find the oldest byte we must keep (min of tok and marker) */
    shift_from = scanner->tok;
    if (scanner->marker < shift_from) {
        shift_from = scanner->marker;
    }
    shift_amount = (size_t)(shift_from - scanner->buf);

    /* Bytes from shift_from to null (inclusive of null terminator) */
    keep_bytes = (size_t)(scanner->null - shift_from) + 1;

    if (shift_amount > 0) {
        /* Compact: move in-use content to the start of the buffer */
        memmove(scanner->buf, shift_from, keep_bytes);
        scanner->tok    -= shift_amount;
        scanner->cursor -= shift_amount;
        scanner->marker -= shift_amount;
        scanner->null   -= shift_amount;
    }

    null_off = (size_t)(scanner->null - scanner->buf);

    /* Grow buffer if we cannot fit RE2C_FILL_BLOCK new bytes */
    while (null_off + RE2C_FILL_BLOCK + 1 > scanner->bufsize) {
        size_t tok_off    = (size_t)(scanner->tok    - scanner->buf);
        size_t cursor_off = (size_t)(scanner->cursor - scanner->buf);
        size_t marker_off = (size_t)(scanner->marker - scanner->buf);

        scanner->bufsize *= 2;
        scanner->buf = (char *)realloc(scanner->buf, scanner->bufsize);

        scanner->tok    = scanner->buf + tok_off;
        scanner->cursor = scanner->buf + cursor_off;
        scanner->marker = scanner->buf + marker_off;
        scanner->null   = scanner->buf + null_off;
    }

    /* Read a block from the file */
    nread = fread(scanner->null, 1, RE2C_FILL_BLOCK, scanner->inFile);
    scanner->null += nread;
    scanner->null[0] = '\0'; /* maintain null-terminator invariant */

    if (nread == 0) {
        scanner->atEOI = 1;
    }

    (void)n; /* re2c 3.x always passes n=1; we read RE2C_FILL_BLOCK instead */
}

/*
 * getTokenText - Extract current token as a null-terminated string.
 *
 * Returns a heap-allocated copy of the text from tok to cursor.
 * The previous tokenText allocation is freed.  Valid until the next
 * call to getTokenText or perplexFree.
 */
static inline char *
getTokenText(perplex_t scanner)
{
    size_t len = (size_t)(scanner->cursor - scanner->tok);

    if (scanner->tokenText != NULL) {
        free(scanner->tokenText);
    }
    scanner->tokenText = (char *)malloc(len + 1);
    memcpy(scanner->tokenText, scanner->tok, len);
    scanner->tokenText[len] = '\0';
    return scanner->tokenText;
}

#endif /* RE2C_SCANNER_H */
