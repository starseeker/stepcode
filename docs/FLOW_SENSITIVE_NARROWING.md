FLOW-SENSITIVE TYPE NARROWING - IMPLEMENTATION NOTES
===================================================

This document describes the flow-sensitive type narrowing implementation for
QUERY expressions over SELECT types with TYPEOF guards.

## Overview

The implementation enables patterns like:
  ('TYPE' IN TYPEOF(var)) AND (QUERY(... <* var | ...))

where var is a SELECT type and TYPE is an aggregate member, allowing QUERY
to work based on the type guard.

## Standards Compliance Status

### ✅ CORRECT BEHAVIOR
- TYPEOF guards only refine when type is in SELECT members (type safety)
- Refinement only applies within RHS of AND (proper scoping)
- No refinement in OR branches
- Nested contexts properly inherit parent refinements
- Type name lookup handles multiple formats (SCHEMA.TYPE, lowercase)

### ⚠️ PERMISSIVE BEHAVIOR
- TYPE_retrieve_aggregate allows QUERY on SELECT with all-aggregate members
- This supports existing AP242 schemas but is not strictly EXPRESS-compliant
- A SELECT is not an aggregate type per the standard

## Known Limitations
1. Guard must be on LEFT of AND (not right)
2. OR and NOT patterns not supported
3. Multiple refinements: later overrides earlier
4. Performance: context copying in deep nesting

## Test Coverage
- treat_comprehensive.exp - Basic patterns
- nested_typeof_guards.exp - Nested ANDs
- type_compat_validation.exp - Type safety
- correctness_review.exp - Edge cases
- AP242 242_mim_lf.exp - Real-world schema

See full documentation in source comments.
