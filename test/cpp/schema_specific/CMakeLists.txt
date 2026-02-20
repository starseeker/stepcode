cmake_minimum_required(VERSION 3.12)
#c++ tests that depend on a particular schema

include_directories( ${SC_SOURCE_DIR}/src/cldai ${SC_SOURCE_DIR}/src/cleditor ${SC_SOURCE_DIR}/src/clutils
  ${SC_SOURCE_DIR}/src/clstepcore )

# helper function for add_schema_dependent_test
# given an sdai target, set out_path_var to the include dir
# added as a workaround for changed behavior in newer cmake
# versions (changes somewhere between 2.8 and 3.1)
function(get_sdai_incl_dir out_path_var sdai_lib)
  # Prefer shared target; fall back to static target in static-only builds
  if(TARGET sdai_${sdai_lib})
    set(_sdai_target sdai_${sdai_lib})
  elseif(TARGET sdai_${sdai_lib}-static)
    set(_sdai_target sdai_${sdai_lib}-static)
  else()
    message("sdai_${sdai_lib} is not a target")
    return()
  endif()
  if(NOT "${sdai_${sdai_lib}_SOURCE_DIR}" STREQUAL "")
    set(${out_path_var} "${sdai_${sdai_lib}_SOURCE_DIR}" PARENT_SCOPE)
    return()
  endif()
  get_target_property(sdai_srcs ${_sdai_target} SOURCES)
  foreach(src ${sdai_srcs})
    if(${src} MATCHES "schema.cc$")
      get_filename_component(incl_path ${src} PATH)
      break()
    endif()
    get_filename_component(src_dir ${src} PATH)
    if(${src_dir} MATCHES "(type|entity)$")
      get_filename_component(incl_path ${src_dir} PATH)
      break()
    endif()
  endforeach()
  if(NOT ${incl_path} EQUAL "")
    set(${out_path_var} ${incl_path} PARENT_SCOPE)
  else()
    message(WARNING "failed to locate incl dir for ${sdai_lib}, given ${sdai_srcs}")
  endif()
endfunction()

# ${name} is used for the C++ file name (${name}.cc), and as the suffix for the target and test names
# ${sdai_lib} is the name of the schema lib that is used
# ${exe_args} are additional args for the test executable
# three optional args: ARGV3, ARGV4, ARGV5 are include paths, compile flags, and libs, respectively.
function(add_schema_dependent_test name sdai_lib exe_args )
  get_sdai_incl_dir(sdai_src_path ${sdai_lib})
  message(STATUS "include dir for ${sdai_lib}: ${sdai_src_path}")
  add_executable(tst_${name} "${name}.cc")
  set_target_properties(tst_${name} PROPERTIES EXCLUDE_FROM_ALL ON)
  set_property(TARGET tst_${name} APPEND PROPERTY INCLUDE_DIRECTORIES ${sdai_src_path} ${ARGV3})
  if(NOT ${ARGV4} STREQUAL "")
    set_property(TARGET tst_${name} APPEND_STRING PROPERTY COMPILE_FLAGS ${ARGV4} )
  endif()
  # Link against the correct schema target: prefer shared, fall back to static
  if(TARGET sdai_${sdai_lib})
    target_link_libraries(tst_${name} sdai_${sdai_lib} ${ARGV5})
  else()
    target_link_libraries(tst_${name} sdai_${sdai_lib}-static ${ARGV5})
  endif()
  add_test(NAME build_cpp_${name}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} --build .
    --target tst_${name}
    --config $<CONFIGURATION> )
  set_tests_properties( build_cpp_${name} PROPERTIES DEPENDS build_cpp_sdai_${sdai_lib}
    LABELS cpp_schema_specific )
  add_test( NAME test_${name}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMAND $<TARGET_FILE:tst_${name}> ${exe_args} )
  set_tests_properties( test_${name} PROPERTIES DEPENDS build_cpp_${name}
    LABELS cpp_schema_specific )
endfunction()

#if you need a schema that won't be built automatically (i.e. not in sc/data), put it in here
# Note: SCHEMA_CMLIST is now idempotent, so these schemas can be built even if they're
# already in SC_BUILD_SCHEMAS without causing conflicts
SCHEMA_CMLIST(${SC_SOURCE_DIR}/test/unitary_schemas/array_bounds_expr.exp)
SCHEMA_CMLIST(${SC_SOURCE_DIR}/test/unitary_schemas/inverse_attr.exp)

# Pick the correct SC library suffix for the active build type
if(BUILD_SHARED_LIBS)
  set(_sc_lib_suffix "")
else()
  set(_sc_lib_suffix "-static")
endif()

add_schema_dependent_test("aggregate_bound_runtime" "array_bounds_expr"
  "${SC_SOURCE_DIR}/test/p21/test_array_bounds.p21" "" "" "stepcore${_sc_lib_suffix}")

#can't use the macro for this one because it depends on the test above and needs WILL_FAIL
add_test( NAME test_aggregate_bound_runtime_FAIL1
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMAND $<TARGET_FILE:tst_aggregate_bound_runtime> "${SC_SOURCE_DIR}/test/p21/test_array_bounds_FAIL1.p21" )
set_tests_properties( test_aggregate_bound_runtime_FAIL1 PROPERTIES
  DEPENDS test_aggregate_bound_runtime WILL_FAIL true
  LABELS cpp_schema_specific )

add_schema_dependent_test( "inverse_attr1" "inverse_attr" "${SC_SOURCE_DIR}/test/p21/test_inverse_attr.p21" )
add_schema_dependent_test( "inverse_attr2" "inverse_attr" "${SC_SOURCE_DIR}/test/p21/test_inverse_attr.p21" )
add_schema_dependent_test( "inverse_attr3" "inverse_attr" "${SC_SOURCE_DIR}/test/p21/test_inverse_attr.p21"
                            "${SC_SOURCE_DIR}/src/cllazyfile;${SC_SOURCE_DIR}/src/cllazyfile/judy/src" "" "steplazyfile${_sc_lib_suffix}" )
add_schema_dependent_test( "attribute" "inverse_attr" "${SC_SOURCE_DIR}/test/p21/test_inverse_attr.p21" )

# This test exercises the STEPfile read/write progress API using std::thread.
# std::thread is guaranteed available since the project requires C++11.
if(UNIX)
  set(_thread_libs "pthread")
endif()
# for best results, use a large file. as1-oc-214.stp is currently the largest file in the repo that sc works with.
add_schema_dependent_test( "stepfile_rw_progress" "ap214e3" "${SC_SOURCE_DIR}/data/ap214e3/as1-oc-214.stp"
                          "" "" "${_thread_libs}")

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

