# Running Tests for Flow-Sensitive Type Narrowing

This document explains how to run the EXPRESS schema tests for flow-sensitive type narrowing.

## Quick Start

### Build and Run Tests (Permissive Mode - Default)

```bash
cd stepcode
mkdir build && cd build
cmake -DSC_BUILD_SCHEMAS="" -DSC_ENABLE_TESTING=ON ..
make check-express
ctest -L flow_narrowing
```

### Build and Run Tests (Strict Mode)

```bash
cd stepcode
mkdir build && cd build
cmake -DSC_BUILD_SCHEMAS="" -DSC_ENABLE_TESTING=ON -DSC_EXPRESS_STRICT=ON ..
make check-express
ctest -L flow_narrowing
```

## Test Organization

### Test Files

All test files are in `test/*.exp`. They are organized as follows:

**Positive Tests (Always Pass):**
- `comprehensive_correctness.exp` - Comprehensive validation of correctness
- `correctness_review.exp` - Edge case testing  
- `extraction_bug.exp` - Tests correct refinement extraction
- `nested_typeof_guards.exp` - Nested AND patterns with TYPEOF
- `or_not_refinement_pass.exp` - Correct TYPEOF guard pattern
- `strict_type_pass.exp` - Valid type refinement
- `treat_comprehensive.exp` - TREAT and TYPEOF patterns

**Negative Tests (Always Fail):**
- `fail_or_not_refinement.exp` - Guards inside OR/NOT (both modes)

**Mode-Dependent Tests:**
- Permissive mode:
  - `query_on_select.exp` - PASS (SELECT with aggregate member)
  - `perm_strict_test.exp` - PASS (demonstrates permissive behavior)
  
- Strict mode only:
  - `fail_definitive_type_strict.exp` - FAIL (invalid type refinement)
  - `fail_perm_strict_strict.exp` - FAIL (no guard in strict mode)
  - `fail_query_on_select_strict.exp` - FAIL (no guard in strict mode)
  - `fail_strict_type_strict.exp` - FAIL (type not in SELECT)
  - `fail_type_compat_validation_strict.exp` - FAIL (invalid type)

### Naming Conventions

- Files beginning with `fail_` are negative tests (expected to fail)
- Files ending with `_strict` only run in strict mode (SC_EXPRESS_STRICT=ON)
- Regular files run in both modes

### How Tests Work

Tests use `check-express` to parse and validate EXPRESS schemas:
- **Pass**: Schema parses without errors (exit code 0)
- **Fail**: Schema has parsing/semantic errors (exit code != 0)

Negative tests (fail_*) are marked with CTest's `WILL_FAIL` property, so when
check-express returns an error, CTest considers the test as passing.

## Running Specific Tests

```bash
# Run all flow narrowing tests
ctest -L flow_narrowing

# Run a specific test
ctest -R test_schema_comprehensive_correctness

# Run all negative tests
ctest -R "test_schema_fail_"

# Run with verbose output
ctest -L flow_narrowing --verbose

# Run with output only on failure
ctest -L flow_narrowing --output-on-failure
```

## Expected Results

**Permissive Mode:**
- 10/10 tests should pass
- fail_ tests are skipped (only run in strict mode)

**Strict Mode:**
- 13/13 tests should pass  
- Includes 6 fail_ tests that correctly detect errors

## Troubleshooting

If tests fail to run:

1. Make sure check-express is built:
   ```bash
   make check-express
   ls bin/check-express  # Should exist
   ```

2. Try running a test manually:
   ```bash
   ./bin/check-express ../test/treat_comprehensive.exp
   ```

3. Check test configuration:
   ```bash
   ctest -N  # List all tests without running
   ```

## Adding New Tests

To add a new test schema:

1. Create a `.exp` file in `test/`
2. Use prefix `fail_` if the test should fail
3. Use suffix `_strict` if it should only run in strict mode
4. Reconfigure CMake:
   ```bash
   cd build
   cmake ..
   ```

The test will be automatically added to the test suite.
