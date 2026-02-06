#
# Adding unittest for unitary schemas
#
file(GLOB UNITARY_SCHEMAS "${CMAKE_CURRENT_SOURCE_DIR}/unitary_schemas/*.exp")
foreach(UNITARY_SCHEMA ${UNITARY_SCHEMAS})
  get_filename_component(SCHEMA_NAME ${UNITARY_SCHEMA} NAME_WE)
  set(TEST_NAME test_unit_${SCHEMA_NAME})
  add_test(${TEST_NAME} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/check-express ${UNITARY_SCHEMA})
  set_tests_properties( ${TEST_NAME} PROPERTIES LABELS unitary_schemas DEPENDS build_check_express )
  #if the file name begins with fail_, then testing it should result in an error.
  if( UNITARY_SCHEMA MATCHES "fail_.*" )
    set_tests_properties( ${TEST_NAME} PROPERTIES WILL_FAIL true )
  endif( UNITARY_SCHEMA MATCHES "fail_.*" )
endforeach(UNITARY_SCHEMA ${UNITARY_SCHEMAS})

#
# Adding tests for flow-sensitive type narrowing and other features
#
file(GLOB TEST_SCHEMAS "${CMAKE_CURRENT_SOURCE_DIR}/*.exp")
foreach(TEST_SCHEMA ${TEST_SCHEMAS})
  get_filename_component(SCHEMA_NAME ${TEST_SCHEMA} NAME_WE)
  
  # Skip mode-dependent tests with _strict suffix in permissive mode
  # These will only be tested in strict mode builds
  if(NOT SC_EXPRESS_STRICT AND SCHEMA_NAME MATCHES ".*_strict$")
    continue()
  endif()
  
  # In strict mode, skip non-strict versions of mode-dependent tests
  if(SC_EXPRESS_STRICT)
    # Skip permissive-only versions of mode-dependent tests
    if(SCHEMA_NAME STREQUAL "query_on_select" OR SCHEMA_NAME STREQUAL "perm_strict_test")
      continue()
    endif()
  endif()
  
  set(TEST_NAME test_schema_${SCHEMA_NAME})
  add_test(${TEST_NAME} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/check-express ${TEST_SCHEMA})
  set_tests_properties( ${TEST_NAME} PROPERTIES LABELS flow_narrowing DEPENDS build_check_express )
  
  # Tests that begin with fail_ should fail
  if( SCHEMA_NAME MATCHES "^fail_.*" )
    set_tests_properties( ${TEST_NAME} PROPERTIES WILL_FAIL true )
  endif()
endforeach(TEST_SCHEMA ${TEST_SCHEMAS})

if(NOT ${SC_BUILD_EXPRESS_ONLY})
  add_subdirectory(p21)
  add_subdirectory(cpp)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

