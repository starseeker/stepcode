# this file should be included from data/CMakeLists.txt
#
# at configure time, this builds a small program
# which will parse express schemas to determine
# what files exp2cxx will create for that schema.
#
# The SCHEMA_CMLIST macro is to be used to run this
# program. It will set variables for schema name(s),
# headers, and implementation files.

# in a unity build, many small .cc files are #included to create a few large translation units
# this makes compilation faster, but sometimes runs into compiler limitations
if(NOT DEFINED SC_UNITY_BUILD)
  message( STATUS "Assuming compiler is capable of unity build. (SC_UNITY_BUILD=TRUE)")
  set(SC_UNITY_BUILD TRUE)
  message( STATUS "Override by setting SC_UNITY_BUILD; TRUE will result in faster build times but *huge* translation units and higher memory use in compilation.")
else()
  message( STATUS "Respecting user-defined SC_UNITY_BUILD value of ${SC_UNITY_BUILD}.")
endif()


# --- variables ---
# SC_ROOT: SC root dir
# SC_BUILDDIR: SC build dir, so generated headers can be found
# SCANNER_SRC_DIR: dir this file is in
# SCANNER_OUT_DIR: location of binary, same dir as SC uses
# SCANNER_BUILD_DIR: location scanner is built

set(SCANNER_SRC_DIR ${PROJECT_SOURCE_DIR}/cmake/schema_scanner)
set(SCANNER_BUILD_DIR ${PROJECT_BINARY_DIR}/schema_scanner CACHE INTERNAL "location for scanner build, config files (copied schemas)")
set(SCANNER_OUT_DIR ${PROJECT_BINARY_DIR}/bin CACHE INTERNAL "location for schema_scanner executable")

# Write a cmake file for the cache. The alternative is a very long
# command line - and the command line can't have newlines in it
set(initial_scanner_cache ${SCANNER_BUILD_DIR}/initial_scanner_cache.cmake)
file(WRITE ${initial_scanner_cache} "
set(SC_ROOT \"${PROJECT_SOURCE_DIR}\" CACHE STRING \"root dir\")
set(SC_BUILDDIR \"${PROJECT_BINARY_DIR}\" CACHE PATH \"build dir\")
set(SC_CMAKE_DIR \"${PROJECT_SOURCE_DIR}/cmake\" CACHE PATH \"cmake dir\")
set(CALLED_FROM \"STEPCODE_CMAKELISTS\" CACHE STRING \"verification\")
set(CMAKE_BUILD_TYPE \"Debug\" CACHE STRING \"build type\")
set(CMAKE_C_COMPILER \"${CMAKE_C_COMPILER}\" CACHE STRING \"compiler\")
set(CMAKE_CXX_COMPILER \"${CMAKE_CXX_COMPILER}\" CACHE STRING \"compiler\")
")

message(STATUS "Compiling schema scanner...")

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${PROJECT_BINARY_DIR}/schemas)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${SCANNER_BUILD_DIR})
execute_process(COMMAND ${CMAKE_COMMAND} -C ${initial_scanner_cache} ${SCANNER_SRC_DIR} -G ${CMAKE_GENERATOR}
                 WORKING_DIRECTORY ${SCANNER_BUILD_DIR}
                 TIMEOUT 60
                 OUTPUT_VARIABLE _ss_config_out
                 RESULT_VARIABLE _ss_config_stat
                 ERROR_VARIABLE _ss_config_err
               )
if(NOT ${_ss_config_stat} STREQUAL "0")
  message(FATAL_ERROR "Scanner config status: ${_ss_config_stat}. stdout:\n${_ss_config_out}\nstderr:\n${_ss_config_err}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build ${SCANNER_BUILD_DIR} --config Debug --clean-first
                 WORKING_DIRECTORY ${SCANNER_BUILD_DIR}
                 TIMEOUT 120 # should take far less than 2m
                 OUTPUT_VARIABLE _ss_build_out
                 RESULT_VARIABLE _ss_build_stat
                 ERROR_VARIABLE _ss_build_err
              )
if(NOT ${_ss_build_stat} STREQUAL "0")
  message(FATAL_ERROR "Scanner build status: ${_ss_build_stat}. stdout:\n${_ss_build_out}\nstderr:\n${_ss_build_err}")
endif()

message( STATUS "Schema scanner built. Running it...")

# not sure if it makes sense to install this or not...
if(WIN32)
	install(PROGRAMS ${SCANNER_OUT_DIR}/schema_scanner.exe DESTINATION ${BIN_DIR})
else()
	install(PROGRAMS ${SCANNER_OUT_DIR}/schema_scanner DESTINATION ${BIN_DIR})
endif()

# macro SCHEMA_CMLIST
# runs the schema scanner on one express file, creating a CMakeLists.txt file for each schema found. Those files are added via add_subdirectory().
#
# SCHEMA_FILE - path to the schema
# TODO should we have a result variable to return schema name(s) found?
macro(SCHEMA_CMLIST SCHEMA_FILE)
  # Run the scanner in a schemas/ subdirectory under the CURRENT binary dir.
  # This ensures the schema binary dir is a direct descendant of the calling
  # CMakeLists.txt's binary dir (no '..' in the path), which is required for
  # CMake's Makefile generator to produce consistent relative target paths in
  # Makefile2 (rule: vs all: entries) when using cmake --build --target.
  set(_schema_out_dir "${CMAKE_CURRENT_BINARY_DIR}/schemas")
  execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${_schema_out_dir})
  execute_process(COMMAND ${SCANNER_OUT_DIR}/schema_scanner ${SCHEMA_FILE}
                   WORKING_DIRECTORY ${_schema_out_dir}
                   RESULT_VARIABLE _ss_stat
                   OUTPUT_VARIABLE _ss_out
                   ERROR_VARIABLE _ss_err
                )
  if(NOT "${_ss_stat}" STREQUAL "0")
    #check size of output, put in file if large?
    message(FATAL_ERROR "Schema scan for '${SCHEMA_FILE}'\nexited with error code '${_ss_stat}'\nstdout:\n${_ss_out}\nstderr:\n${_ss_err}\n")
  endif()
  # scanner output format: each line contains an absolute path. each path is a dir containing a CMakeLists for one schema
  # there will usually be a single line of output, but it is not illegal for multiple schemas to exist in one .exp file
  string(STRIP "${_ss_out}" _ss_stripped)
  string(REGEX REPLACE "\\\n" ";" _list ${_ss_stripped})
  foreach(_dir ${_list})
    # Extract schema name from directory path to check if already added
    get_filename_component(_schema_name ${_dir} NAME)
    # Track which schema directories have been added to prevent duplicate add_subdirectory calls
    # (prevents conflicts when schema is in both SC_BUILD_SCHEMAS and explicitly called in tests)
    get_property(_already_added GLOBAL PROPERTY SC_SCHEMA_${_schema_name}_ADDED)
    if(NOT _already_added)
      # Pass the absolute path as both source and binary dir. The schema scanner
      # places source and generated files in the same directory, so they are the same.
      # Note: CMake 3.13+ Makefile generator emits absolute paths in the 'rule:'
      # recursive $(MAKE) call for any add_subdirectory with absolute source paths,
      # while 'all:' entries always use relative paths. SCHEMA_TESTS works around
      # this inconsistency for the Unix Makefiles generator.
      add_subdirectory(${_dir} ${_dir}) #source and binary dir are the same absolute path
      set_property(GLOBAL PROPERTY SC_SCHEMA_${_schema_name}_ADDED TRUE)
    else()
      message(STATUS "Schema ${_schema_name} already configured, skipping duplicate add_subdirectory")
    endif()
  endforeach()
  # configure_file forces cmake to run again if the schema has been modified
  #if multiple schemas in one file, _schema is the last one printed.
  # 2e6ee669 removed _schema, does this still work?
  configure_file(${SCHEMA_FILE} ${SCANNER_BUILD_DIR}/${_schema})
endmacro()
