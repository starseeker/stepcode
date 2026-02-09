# CMake generated Testfile for 
# Source directory: /home/runner/work/stepcode/stepcode/src/exp2cxx/test
# Build directory: /home/runner/work/stepcode/stepcode/build_test/src/exp2cxx/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(build_exp2cxx "/usr/local/bin/cmake" "--build" "." "--target" "exp2cxx" "--config" "")
set_tests_properties(build_exp2cxx PROPERTIES  WORKING_DIRECTORY "/home/runner/work/stepcode/stepcode/build_test" _BACKTRACE_TRIPLES "/home/runner/work/stepcode/stepcode/src/exp2cxx/test/CMakeLists.txt;5;add_test;/home/runner/work/stepcode/stepcode/src/exp2cxx/test/CMakeLists.txt;0;")
add_test(test_exp2cxx_unique_qualifiers "/usr/local/bin/cmake" "-DEXE=/home/runner/work/stepcode/stepcode/build_test/bin/exp2cxx" "-DINFILE=/home/runner/work/stepcode/stepcode/test/unitary_schemas/unique_qualifiers.exp" "-P" "/home/runner/work/stepcode/stepcode/src/exp2cxx/test/unique_qualifiers.cmake")
set_tests_properties(test_exp2cxx_unique_qualifiers PROPERTIES  DEPENDS "build_exp2cxx" WORKING_DIRECTORY "/home/runner/work/stepcode/stepcode/build_test/src/exp2cxx/test" _BACKTRACE_TRIPLES "/home/runner/work/stepcode/stepcode/src/exp2cxx/test/CMakeLists.txt;12;add_test;/home/runner/work/stepcode/stepcode/src/exp2cxx/test/CMakeLists.txt;0;")
add_test(test_exp2cxx_inverse_qualifiers "/usr/local/bin/cmake" "-DEXE=/home/runner/work/stepcode/stepcode/build_test/bin/exp2cxx" "-DINFILE=/home/runner/work/stepcode/stepcode/test/unitary_schemas/inverse_qualifiers.exp" "-P" "/home/runner/work/stepcode/stepcode/src/exp2cxx/test/inverse_qualifiers.cmake")
set_tests_properties(test_exp2cxx_inverse_qualifiers PROPERTIES  DEPENDS "build_exp2cxx" WORKING_DIRECTORY "/home/runner/work/stepcode/stepcode/build_test/src/exp2cxx/test" _BACKTRACE_TRIPLES "/home/runner/work/stepcode/stepcode/src/exp2cxx/test/CMakeLists.txt;19;add_test;/home/runner/work/stepcode/stepcode/src/exp2cxx/test/CMakeLists.txt;0;")
