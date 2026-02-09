# Precompiled Headers in STEPcode

## Overview

STEPcode now supports precompiled headers (PCH) to improve compilation times for schema libraries. This document explains the feature, its benefits, and how to use it.

## What are Precompiled Headers?

Precompiled headers are a compilation optimization where commonly-used header files are pre-processed once and reused across multiple translation units. This reduces redundant parsing of the same headers in every source file.

## Implementation

STEPcode's PCH implementation targets schema compilation, where thousands of generated C++ files share common dependencies on the STEP core libraries.

### Files Involved

1. **`include/schema_pch.h`** - The precompiled header file containing:
   - Core STEP headers (sdai.h, Registry.h, ExpDict.h, etc.)
   - Standard library headers (string, ctype.h)
   - Common utility headers (Str.h, errordesc.h)

2. **`cmake/SC_CXX_schema_macros.cmake`** - Updated to:
   - Enable PCH via `target_precompile_headers()` for schema libraries
   - Support the `SC_ENABLE_PRECOMPILED_HEADERS` option

3. **`CMakeLists.txt`** - Added:
   - Configuration messages about PCH status
   - Default PCH enablement

## Requirements

- CMake 3.16 or later (current requirement: CMake 3.12)
- Compiler with PCH support (GCC, Clang, MSVC all supported)

## Usage

### Enable PCH (Default)

PCH is enabled by default. Simply configure and build as normal:

```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242"
make
```

### Disable PCH

To disable PCH, set the CMake variable:

```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_ENABLE_PRECOMPILED_HEADERS=OFF
make
```

## Performance Impact

Build time improvements depend on several factors:

### With Unity Build (Default: `SC_UNITY_BUILD=TRUE`)

Unity build already provides excellent optimization by combining multiple source files into single translation units. PCH provides minimal additional benefit:

- **ap242 schema (4012 files):**
  - Without PCH: 41.5 seconds
  - With PCH: 41.3 seconds
  - **Improvement: <1%**

### Without Unity Build (`SC_UNITY_BUILD=OFF`)

When unity build is disabled (e.g., for debugging or when compiler memory is limited), PCH provides significant benefit:

- **ap242 schema (4012 files):**
  - Without PCH: 15m 23s
  - With PCH: 12m 35s
  - **Improvement: ~18% (168 seconds saved)**

### Small Schemas

For small schemas (e.g., ap203 with 602 files), the overhead of creating the PCH can outweigh benefits:

- **ap203 schema (602 files):**
  - Without PCH: 14.2 seconds
  - With PCH: 14.5 seconds
  - **Improvement: Negligible**

## Recommendations

1. **Keep PCH enabled (default)**: There's no significant downside, and it provides substantial benefit when unity build is disabled.

2. **Disable unity build only when necessary**: Unity build provides the best overall compilation performance. Disable it only for:
   - Debugging (to avoid huge translation units)
   - Memory-constrained build environments
   - Parallel builds with limited resources

3. **Combine with parallel builds**: Use `make -j<N>` to maximize build performance with or without PCH.

## Technical Details

### Headers Included in PCH

The PCH includes headers that are universally used in generated schema code:

```cpp
// Core STEP headers
#include "clstepcore/sdai.h"
#include "clstepcore/Registry.h"
#include "clstepcore/STEPaggregate.h"
#include "clstepcore/STEPundefined.h"
#include "clstepcore/ExpDict.h"
#include "clstepcore/STEPattribute.h"
#include "clstepcore/STEPattributeList.h"
#include "clstepcore/STEPinvAttrList.h"
#include "clstepcore/complexSupport.h"

// Utility headers
#include "clutils/Str.h"
#include "clutils/errordesc.h"
```

These headers are included in every generated schema file's wrapper header (e.g., `SdaiXXX.h`), making them ideal PCH candidates.

### How CMake PCH Works

CMake's `target_precompile_headers()` command:
1. Creates a compiler-specific PCH file (e.g., `.gch` for GCC, `.pch` for MSVC)
2. Adds compiler flags to use the PCH in all source files for the target
3. Ensures the PCH is rebuilt if any included headers change

The PCH is target-specific, so each schema library gets its own precompiled header instance.

## Troubleshooting

### PCH Not Being Created

If you don't see `cmake_pch.hxx.gch` in build output:
1. Check CMake version: `cmake --version` (need 3.16+)
2. Verify PCH is enabled: Check for "Precompiled headers are ENABLED" message
3. Check compiler support: PCH requires a compatible compiler

### Build Errors with PCH

If you encounter errors with PCH enabled:
1. Try a clean build: `rm -rf build && mkdir build`
2. Disable PCH temporarily: `-DSC_ENABLE_PRECOMPILED_HEADERS=OFF`
3. Report the issue with compiler version and error messages

### Memory Issues

Large PCH files can increase memory usage during compilation. If you encounter memory errors:
1. Reduce parallel build jobs: `make -j2` instead of `make -j8`
2. Enable unity build: `-DSC_UNITY_BUILD=ON` (default)
3. Disable PCH: `-DSC_ENABLE_PRECOMPILED_HEADERS=OFF`

## Future Enhancements

Potential improvements to consider:

1. **Schema-specific PCH tuning**: Different schemas might benefit from different PCH content
2. **Core library PCH**: Apply PCH to stepcore, stepdai, etc. (currently only schema libs use it)
3. **CMake minimum version bump**: Require CMake 3.16+ to make PCH always available
4. **Automatic PCH content**: Generate PCH content based on actual header usage analysis

## References

- [CMake Precompiled Headers Documentation](https://cmake.org/cmake/help/latest/command/target_precompile_headers.html)
- [GCC Precompiled Headers](https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html)
- [MSVC Precompiled Headers](https://docs.microsoft.com/en-us/cpp/build/creating-precompiled-header-files)
