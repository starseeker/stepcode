#
# CMakeLists.txt for AP203 Minimum
#
#  This file is released to the public domain.  Any part of this file may be
# freely copied in part or in full for any purpose.  No acknowledgment is required
# for the use of this file.
#
cmake_minimum_required(VERSION 3.12)
project(AP203Minimum)

# ---------------------------------------------------------------------------
# Option 1 (recommended): Use an installed STEPcode package.
#   Install STEPcode, then point CMake at the install prefix:
#     cmake -DCMAKE_PREFIX_PATH=/path/to/stepcode/install ..
# ---------------------------------------------------------------------------
find_package(SC CONFIG QUIET)

if(SC_FOUND)
  message(STATUS "Using installed STEPcode (${SC_CMAKE_DIR})")

  # Schema library name derived from the ap203 schema.
  set(SCHEMA_LINK_NAME sdai_ap203)

  add_executable(${PROJECT_NAME} ap203min.cpp)

  # Link against STEPcode using the installed imported targets.
  target_link_libraries(${PROJECT_NAME} PRIVATE
    SC::stepeditor
    SC::stepcore
    SC::stepdai
    SC::steputils
    ${SCHEMA_LINK_NAME}
  )

  # Schema-generated headers are installed under include/schemas/<schema_name>.
  target_include_directories(${PROJECT_NAME} PRIVATE
    "${SC_INCLUDE_DIR}/schemas/${SCHEMA_LINK_NAME}"
  )

else()

# ---------------------------------------------------------------------------
# Option 2 (fallback): Build STEPcode from source as a sub-project.
#   Set STEPCODE_ROOT_DIR to the root of the STEPcode source tree:
#     cmake -DSTEPCODE_ROOT_DIR=/path/to/stepcode ..
# ---------------------------------------------------------------------------

  if(NOT DEFINED STEPCODE_ROOT_DIR)
    message(FATAL_ERROR
      "STEPcode was not found as an installed package and STEPCODE_ROOT_DIR is not set.\n"
      "Either install STEPcode and set CMAKE_PREFIX_PATH to the install prefix, or\n"
      "set STEPCODE_ROOT_DIR to the STEPcode source tree:\n"
      "  cmake -DSTEPCODE_ROOT_DIR=/path/to/stepcode ..")
  endif()

  # Resolve STEPCODE_ROOT_DIR to an absolute path.
  if(EXISTS "${CMAKE_BINARY_DIR}/${STEPCODE_ROOT_DIR}/src/express/express.c")
    set(STEPCODE_ROOT_DIR "${CMAKE_BINARY_DIR}/${STEPCODE_ROOT_DIR}")
    message(STATUS "STEPCODE_ROOT_DIR resolved to absolute path: ${STEPCODE_ROOT_DIR}")
  elseif(NOT EXISTS "${STEPCODE_ROOT_DIR}/src/express/express.c")
    message(FATAL_ERROR "Cannot locate STEPcode source at STEPCODE_ROOT_DIR='${STEPCODE_ROOT_DIR}'")
  endif()

  # Tell STEPcode it is being built as part of another project.
  set(SC_IS_SUBBUILD TRUE)

  # Build type, DEBUG or RELEASE
  if(NOT DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
  endif()

  # Path where the STEPcode sub-build will be placed.
  set(STEPCODE_BUILD_DIR ${CMAKE_BINARY_DIR}/sc CACHE PATH "STEPcode build subdir")

  # STEP schema to build and link against.
  set(SCHEMA ap203)
  set(SC_BUILD_SCHEMAS ${SCHEMA} CACHE INTERNAL "Schema, internal, immutable" FORCE)

  # Locate the express schema file.
  file(GLOB SCHEMA_FILE "${STEPCODE_ROOT_DIR}/data/${SCHEMA}/*.exp")
  if(NOT EXISTS "${SCHEMA_FILE}")
    message(FATAL_ERROR "Cannot find schema file in ${STEPCODE_ROOT_DIR}/data/${SCHEMA}/")
  endif()

  get_filename_component(SCHEMA_SN "${SCHEMA_FILE}" NAME)
  string(REGEX REPLACE "(.*)\\.[Ee][Xx][Pp]" "sdai_\\1" SCHEMA_LINK_NAME "${SCHEMA_SN}")

  # Add STEPcode as a sub-project.
  add_subdirectory(${STEPCODE_ROOT_DIR} "${CMAKE_CURRENT_BINARY_DIR}/sc" EXCLUDE_FROM_ALL)

  # Place output files alongside this project's outputs, not inside the sc sub-dir.
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

  add_executable(${PROJECT_NAME} ap203min.cpp)

  # Use modern target-based includes; the sub-build targets carry their own
  # include directory requirements transitively.
  target_include_directories(${PROJECT_NAME} PRIVATE
    "${STEPCODE_ROOT_DIR}/include"
    "${STEPCODE_BUILD_DIR}/include"
    "${CMAKE_BINARY_DIR}"
    "${STEPCODE_BUILD_DIR}/schemas/${SCHEMA_LINK_NAME}"
  )

  target_link_libraries(${PROJECT_NAME} PRIVATE
    stepeditor
    stepcore
    stepdai
    steputils
    ${SCHEMA_LINK_NAME}
  )

endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

