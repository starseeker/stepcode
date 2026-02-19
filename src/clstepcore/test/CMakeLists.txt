CMAKE_MINIMUM_REQUIRED(VERSION 3.12)
#c++ tests for clstepcore

include_directories(
  ${SC_SOURCE_DIR}/src/cldai ${SC_SOURCE_DIR}/src/cleditor
  ${SC_SOURCE_DIR}/src/clstepcore
)

function(add_stepcore_test name libs)
  SC_ADDEXEC(tst_${name} SOURCES test_${name}.cc LINK_LIBRARIES ${libs} TESTABLE)
  add_test(NAME build_cpp_${name}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} --build .
      --target tst_${name}
      --config $<CONFIGURATION>)
  add_test(NAME test_${name}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMAND $<TARGET_FILE:tst_${name}>)
  set_tests_properties(build_cpp_${name} PROPERTIES LABELS cpp_unit_stepcore DEPENDS stepcore)
  set_tests_properties(test_${name} PROPERTIES LABELS cpp_unit_stepcore DEPENDS build_cpp_${name})
endfunction()

if(BUILD_SHARED_LIBS OR NOT BUILD_STATIC_LIBS)
  set(_stepcore_test_libs "stepcore;steputils;stepeditor;stepdai")
else()
  set(_stepcore_test_libs "stepcore-static;steputils-static;stepeditor-static;stepdai-static")
endif()
add_stepcore_test("SupertypesIterator" "${_stepcore_test_libs}") #all these libs are necessary?
add_stepcore_test("operators_STEPattribute" "${_stepcore_test_libs}")
add_stepcore_test("operators_SDAI_Select" "${_stepcore_test_libs}")
add_stepcore_test("null_attr" "${_stepcore_test_libs}")

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
