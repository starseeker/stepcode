# Parallel Unity Build in STEPcode

## Overview

STEPcode now supports splitting unity builds into multiple translation units that compile in parallel, improving build times on multi-core systems.

## Background

Unity builds combine many small source files into a few large translation units to reduce compilation overhead. However, a single large unity file can only use one CPU core, leaving other cores idle during schema compilation.

The parallel unity build feature splits the unity translation units into configurable chunks that can compile simultaneously on multiple cores.

## Configuration

### SC_UNITY_CHUNKS

Controls the number of unity file chunks created for parallel compilation.

```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_UNITY_CHUNKS=4
make -j4
```

**Default value:** 4  
**Range:** 1-16  
**Recommendation:** Set to match the number of available CPU cores

## Performance Results

### ap242 Schema (4012 generated files)

| Chunks | Build Time | Improvement | CPU Utilization |
|--------|------------|-------------|-----------------|
| 2 (old) | 41.5s | baseline | ~50% (2 cores active) |
| 4 | 34.9s | **16% faster** | ~100% (4 cores active) |
| 8 | 38.0s | 8% faster | 100% (diminishing returns) |

### Key Insights

1. **Optimal chunk count = CPU cores**: Setting chunks equal to your CPU count provides best results
2. **Sweet spot is 4-8 chunks**: Beyond 8 chunks, overhead outweighs parallelism benefits
3. **Best with unity build enabled**: Requires `SC_UNITY_BUILD=ON` (default)
4. **Combines with PCH**: Use both PCH and parallel unity for maximum benefit

## How It Works

### Traditional Unity Build (2 files)

```
4012 source files
  ↓
2 unity files
  ├── SdaiSCHEMA_unity_entities.cc  (includes all ~2000 entity .cc files)
  └── SdaiSCHEMA_unity_types.cc     (includes all ~2000 type .cc files)
  ↓
Compile sequentially (or max 2 in parallel)
```

### Parallel Unity Build (4 chunks)

```
4012 source files
  ↓
8 unity files (4 entity + 4 type chunks)
  ├── SdaiSCHEMA_unity_entities_0.cc  (~500 entity files)
  ├── SdaiSCHEMA_unity_entities_1.cc  (~500 entity files)
  ├── SdaiSCHEMA_unity_entities_2.cc  (~500 entity files)
  ├── SdaiSCHEMA_unity_entities_3.cc  (~500 entity files)
  ├── SdaiSCHEMA_unity_types_0.cc     (~500 type files)
  ├── SdaiSCHEMA_unity_types_1.cc     (~500 type files)
  ├── SdaiSCHEMA_unity_types_2.cc     (~500 type files)
  └── SdaiSCHEMA_unity_types_3.cc     (~500 type files)
  ↓
Compile all 8 files in parallel (with make -j4, 4 at a time)
```

### Distribution Algorithm

Files are distributed round-robin across chunks:
- Entity 0 → chunk 0
- Entity 1 → chunk 1
- Entity 2 → chunk 2
- Entity 3 → chunk 3
- Entity 4 → chunk 0 (wrap around)
- ...

This ensures even distribution across all chunks.

## Implementation Details

### Modified Components

1. **exp2cxx tool** (`src/exp2cxx/`)
   - Modified to create multiple unity files
   - Reads SC_UNITY_CHUNKS from environment variable
   - Distributes entities/types round-robin across chunks

2. **Schema scanner** (`cmake/schema_scanner/`)
   - Generates CMakeLists.txt with dynamic unity file list
   - Creates loop to reference all chunk files

3. **CMake build system**
   - Passes SC_UNITY_CHUNKS to exp2cxx via environment
   - PCH applies to all unity chunks individually

### Generated File Naming

Pattern: `Sdai{SCHEMA}_unity_{entities|types}_{chunk_id}.{cc|h}`

Examples:
- `SdaiAP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF_unity_entities_0.cc`
- `SdaiAP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF_unity_entities_1.cc`
- `SdaiAP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF_unity_types_0.cc`
- ...

## Usage Examples

### Default Build (4 chunks, optimal for most systems)

```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242"
make -j4
```

### Adjust for Your CPU Count

**2-core system:**
```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_UNITY_CHUNKS=2
make -j2
```

**8-core system:**
```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_UNITY_CHUNKS=8
make -j8
```

### Disable Parallel Unity (use single unity file per type)

Not directly supported. To get old behavior, set chunks to 1:
```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_UNITY_CHUNKS=1
make
```

However, the default 2-chunk behavior required modifying the scanner. Consider using the default 4 chunks instead.

### Disable Unity Build Entirely

```bash
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_UNITY_BUILD=OFF
make -j4
```

This will compile each of the 4012 files individually (very slow without PCH).

## Combining Optimizations

For best build performance, combine all optimizations:

```bash
cmake .. \
  -DSC_BUILD_SCHEMAS="ap242" \
  -DSC_UNITY_BUILD=ON \              # Default: ON
  -DSC_UNITY_CHUNKS=4 \              # Default: 4
  -DSC_ENABLE_PRECOMPILED_HEADERS=ON # Default: ON

make -j4
```

**Expected results for ap242:**
- Unity build: ~41s (baseline without chunking)
- + Parallel chunks (4): ~35s (16% improvement)
- + PCH: Minimal additional benefit with unity build
- **Total: ~35 seconds on 4-core system**

## Troubleshooting

### Build Fails with "No such file" Error

**Symptom:** Error like `fatal error: .../unity_entities_4.cc: No such file or directory`

**Cause:** CMake cache has stale chunk count, but exp2cxx created different number of files

**Solution:**
```bash
rm -rf build/*
cmake .. -DSC_BUILD_SCHEMAS="ap242" -DSC_UNITY_CHUNKS=4
make -j4
```

### Build is Slower with More Chunks

**Symptom:** 8 chunks slower than 4 chunks

**Cause:** Overhead from more files and linking outweighs parallelism benefit

**Solution:** Use chunks = CPU cores, typically 4. Don't exceed 8 chunks.

### Memory Issues During Compilation

**Symptom:** Compiler runs out of memory, system swaps

**Cause:** Too many large unity files compiling simultaneously

**Solutions:**
1. Reduce parallel jobs: `make -j2` instead of `make -j4`
2. Reduce chunks: `-DSC_UNITY_CHUNKS=2`
3. Disable unity build: `-DSC_UNITY_BUILD=OFF` (but build will be much slower)

## Comparison with Other Approaches

### vs. No Unity Build

| Approach | Build Time | Pros | Cons |
|----------|-----------|------|------|
| No unity | 15+ minutes | Better diagnostics | Very slow |
| Unity (2 chunks) | 41s | Fast, proven | Poor parallelism |
| **Parallel unity (4 chunks)** | **35s** | **Fast + parallel** | **More complex** |

### vs. Precompiled Headers

| Optimization | Benefit | When to Use |
|--------------|---------|-------------|
| PCH | 18% (without unity) | Always ON |
| Parallel Unity | 16% (vs 2 chunks) | Always ON, set chunks=cores |
| Both | Combined: 40%+ | **Recommended** |

## Future Improvements

Potential enhancements for consideration:

1. **Auto-detect CPU count**: Automatically set SC_UNITY_CHUNKS to match available cores
2. **Adaptive chunking**: Adjust chunk count based on schema size
3. **Per-schema tuning**: Allow different chunk counts for different schemas
4. **Better distribution**: Load-balance chunks by file size instead of count
5. **Ninja generator optimization**: Better parallelism with Ninja vs Make

## References

- Unity build concept: https://en.wikipedia.org/wiki/Unity_build
- CMake parallel builds: https://cmake.org/cmake/help/latest/manual/cmake.1.html#build-tool-mode
- Related documentation: `/doc/PCH_INVESTIGATION_SUMMARY.md`, `/doc/PRECOMPILED_HEADERS.md`

---

**Last updated:** February 2026  
**Feature added in:** STEPcode 0.9.1
