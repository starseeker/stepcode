#
# CMakeLists.txt for AP203 Minimum (ExternalProject build)
#
# This variant builds STEPcode via CMake's ExternalProject mechanism,
# installs it to a local prefix, and then links against the installed
# static libraries.  It is useful when you need to pin a specific version
# of STEPcode or keep it completely isolated from your project's build tree.
#
#  This file is released to the public domain.  Any part of this file may be
# freely copied in part or in full for any purpose.  No acknowledgment is required
# for the use of this file.
#
cmake_minimum_required(VERSION 3.12)
project(AP203Minimum)

include(ExternalProject)

set(CMAKE_MODULE_PATH "${AP203Minimum_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

include(External_STEPCode)

message(STATUS "STEPCODE_INSTALL_DIR: ${STEPCODE_INSTALL_DIR}")

# Create IMPORTED targets for the installed STEPcode static libraries so
# that downstream targets can use modern target-based linking.
set(_sc_libs steputils stepdai stepcore stepeditor sdai_ap203)
foreach(_lib ${_sc_libs})
  add_library(SC::${_lib} STATIC IMPORTED)
  if(WIN32)
    set_target_properties(SC::${_lib} PROPERTIES
      IMPORTED_LOCATION "${STEPCODE_INSTALL_DIR}/lib/lib${_lib}.lib")
  else()
    set_target_properties(SC::${_lib} PROPERTIES
      IMPORTED_LOCATION "${STEPCODE_INSTALL_DIR}/lib/lib${_lib}.a")
  endif()
  add_dependencies(SC::${_lib} STEPCODE)
endforeach()

# On Windows, the express and exppp static libs are also required.
if(WIN32)
  foreach(_lib express exppp)
    add_library(SC::${_lib} STATIC IMPORTED)
    set_target_properties(SC::${_lib} PROPERTIES
      IMPORTED_LOCATION "${STEPCODE_INSTALL_DIR}/lib/lib${_lib}.lib")
    add_dependencies(SC::${_lib} STEPCODE)
  endforeach()
  target_link_libraries(SC::steputils INTERFACE shlwapi)
endif()

set(STEPCODE_INCLUDE_DIRS
  "${STEPCODE_INSTALL_DIR}/include/stepcode"
  "${STEPCODE_INSTALL_DIR}/include/stepcode/clstepcore"
  "${STEPCODE_INSTALL_DIR}/include/stepcode/cldai"
  "${STEPCODE_INSTALL_DIR}/include/stepcode/clutils"
  "${STEPCODE_INSTALL_DIR}/include/stepcode/cleditor"
  "${STEPCODE_INSTALL_DIR}/include/schemas/sdai_ap203"
)

add_executable(${PROJECT_NAME} ../ap203min.cpp)

add_dependencies(${PROJECT_NAME} STEPCODE)

target_include_directories(${PROJECT_NAME} PRIVATE ${STEPCODE_INCLUDE_DIRS})

target_link_libraries(${PROJECT_NAME} PRIVATE
  SC::stepeditor
  SC::stepcore
  SC::stepdai
  SC::steputils
  SC::sdai_ap203
)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

