#
# CMakeLists.txt for AP203 Minimum
#
#  This file is released to the public domain.  Any part of this file may be
# freely copied in part or in full for any purpose.  No acknowledgment is required
# for the use of this file.
#
cmake_minimum_required(VERSION 3.12)
project(AP203Minimum)

INCLUDE( ExternalProject )

set(CMAKE_MODULE_PATH ${AP203Minimum_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

INCLUDE( External_STEPCode )

#####
# IMPORTED targets for STEPcode libraries

foreach(_lib stepcore stepeditor stepdai steputils sdai_ap203)
  add_library(SC::${_lib} STATIC IMPORTED)
  set_target_properties(SC::${_lib} PROPERTIES
    IMPORTED_LOCATION
      "${STEPCODE_INSTALL_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}${_lib}${CMAKE_STATIC_LIBRARY_SUFFIX}"
  )
  add_dependencies(SC::${_lib} STEPCODE)
endforeach()

MESSAGE( STATUS "STEPCODE_INSTALL_DIR: " ${STEPCODE_INSTALL_DIR} )

set( STEPCODE_INCLUDE_DIR
${STEPCODE_INSTALL_DIR}/include/stepcode
${STEPCODE_INSTALL_DIR}/include/stepcode/clstepcore
${STEPCODE_INSTALL_DIR}/include/stepcode/cldai
${STEPCODE_INSTALL_DIR}/include/stepcode/clutils
${STEPCODE_INSTALL_DIR}/include/stepcode/cleditor
${STEPCODE_INSTALL_DIR}/include/schemas/sdai_ap203
)

# End of variables ideally set by FindSTEPCode.cmake
######


include_directories(
    ${STEPCODE_INCLUDE_DIR}
)

set(SRCS ../ap203min.cpp)

set(HDRS )

add_executable( ${PROJECT_NAME} ${SRCS} ${HDRS})

add_dependencies( ${PROJECT_NAME} STEPCODE )

target_link_libraries( ${PROJECT_NAME}
    SC::stepeditor SC::stepcore SC::stepdai SC::steputils SC::sdai_ap203
)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8
