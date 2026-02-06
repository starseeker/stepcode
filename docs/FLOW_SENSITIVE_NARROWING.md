FLOW-SENSITIVE TYPE NARROWING - IMPLEMENTATION NOTES
===================================================

This document describes the flow-sensitive type narrowing implementation for
QUERY expressions over SELECT types with TYPEOF guards.

## Overview

The implementation enables patterns like:
  ('TYPE' IN TYPEOF(var)) AND (QUERY(... <* var | ...))

where var is a SELECT type and TYPE is an aggregate member, allowing QUERY
to work based on the type guard.

## Permissive vs Strict Mode

STEPcode supports two modes for handling QUERY on SELECT types:

### PERMISSIVE MODE (Default)
- **When**: Default behavior (EXPRESS_STRICT not defined)
- **Behavior**: Allows QUERY on SELECT if ALL members are aggregates with the same base type
- **Purpose**: Supports real-world schemas like AP242 that use this pattern
- **Standards**: Not strictly compliant with EXPRESS standard, but practical
- **Use case**: Production use with ISO schemas like AP242

### STRICT MODE
- **When**: Set CMake option `-DSC_EXPRESS_STRICT=ON`
- **Behavior**: SELECT is never treated as an aggregate (per EXPRESS standard)
- **Purpose**: Enforce standards-compliant behavior
- **Standards**: Fully compliant with EXPRESS specification
- **Use case**: Validating new schemas for strict compliance

### Switching Modes

```bash
# Default (permissive) - allows AP242 to compile
cmake ..

# Strict mode - enforce standard compliance
cmake -DSC_EXPRESS_STRICT=ON ..
```

## Standards Compliance Status

### ✅ CORRECT BEHAVIOR (Both Modes)
- TYPEOF guards only refine when type is in SELECT members (type safety)
- Refinement only applies within RHS of AND (proper scoping)
- No refinement in OR branches - explicitly blocked
- No refinement in NOT branches - explicitly blocked  
- Nested contexts properly inherit parent refinements
- Type name lookup handles multiple formats (SCHEMA.TYPE, lowercase)
- TYPEOF detection uses function pointer comparison (reliable)
- String literal detection checks expression kind (not just type)

### MODE-SPECIFIC BEHAVIOR

**Permissive Mode:**
- SELECT with all-aggregate members can be used in QUERY
- Enables AP242 and similar real-world schemas to compile
- Type narrowing with TYPEOF still works and is recommended

**Strict Mode:**
- SELECT types are never treated as aggregates per EXPRESS standard
- Type narrowing with TYPEOF guards is required for QUERY on SELECT
- Enforces best practices and standards compliance

## Implementation Details

### TYPEOF Detection
TYPEOF is detected by comparing `expr->u.funcall.function` to the global
`FUNC_TYPEOF` pointer. This is more reliable than string comparison because
the function pointer is set during expression resolution and cannot be
spoofed by other symbols.

### String Literal Detection
String literals are detected by checking `expr->type->u.type->body->type == string_`
rather than checking if the expression's type is String. This ensures we only
accept actual literal strings like 'TYPE_NAME', not arbitrary string-valued
expressions.

### Refinement Extraction Safety
The `extract_all_refinements()` function only traverses through AND operators
and explicitly does NOT descend into OR, NOT, or other operators. This ensures
refinements are only extracted from guards that are guaranteed to be true when
the refined code executes.

Safe pattern: `GUARD AND USE` - refinement applied to USE
Unsafe patterns (blocked):
- `(GUARD OR X) AND USE` - guard might not hold
- `NOT(NOT(GUARD)) AND USE` - even though logically equivalent, blocked for safety
- Complex boolean expressions with mixed operators - conservative default

## Known Limitations
1. Guard must be on LEFT of AND (not right)
2. Multiple refinements: later overrides earlier
3. Performance: context copying in deep nesting

## Test Coverage
- treat_comprehensive.exp - Basic patterns
- nested_typeof_guards.exp - Nested ANDs
- type_compat_validation.exp - Type safety
- correctness_review.exp - Edge cases
- or_not_refinement_test.exp - OR/NOT safety
- query_on_select.exp - Negative test (should fail)
- definitive_type_test.exp - Type incompatibility (should fail)
- AP242 242_mim_lf.exp - Real-world schema

See full documentation in source comments.
