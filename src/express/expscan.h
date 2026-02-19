/*
 * expscan.h - Express scanner public interface
 *
 * This header defines the scanner type and declares the public API
 * used by the Express parser and related code.  It replaces the old
 * perplex-template-generated header.
 */

#ifndef EXPSCAN_H
#define EXPSCAN_H

#include <stdio.h>
#include "re2c_scanner.h"

/* -----------------------------------------------------------------------
 * Public scanner API
 *
 * These functions are implemented in expscan.c (generated from expscan.re).
 * They are declared here as regular extern functions so that they can be
 * mocked (e.g. with FFF) in unit tests.
 * --------------------------------------------------------------------- */

perplex_t perplexFileScanner(FILE *input);
perplex_t perplexStringScanner(char *firstChar, size_t numChars);
void      perplexFree(perplex_t scanner);
void      perplexUnput(perplex_t scanner, char c);
void      perplexSetExtra(perplex_t scanner, void *extra);
void     *perplexGetExtra(perplex_t scanner);

/* -----------------------------------------------------------------------
 * Scanner entry points
 * --------------------------------------------------------------------- */

#ifndef PERPLEX_LEXER
#  define PERPLEX_LEXER yylex
#endif

#define PERPLEX_PUBLIC_LEXER  PERPLEX_LEXER(perplex_t scanner)

int PERPLEX_PUBLIC_LEXER;

void SCAN_lex_init(char *filename, FILE *fp);
void SCANskip_to_end_schema(perplex_t scanner);

/* -----------------------------------------------------------------------
 * Condition enum (order matches re2c's assignment in expscan.re:
 *   INITIAL appears first, then code, then return_end_schema as the first
 *   condition that appears as a rule source-label after code, then comment)
 * --------------------------------------------------------------------- */
enum YYCONDTYPE {
    yycINITIAL           = 0,
    yyccode              = 1,
    yycreturn_end_schema = 2,
    yyccomment           = 3
};

#endif /* EXPSCAN_H */
