# Install script for directory: /home/runner/work/stepcode/stepcode/include/cldai

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/stepcode/cldai" TYPE FILE FILES
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiApplication_instance_set.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiBinary.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiDaObject.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiEntity_extent.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiEntity_extent_set.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiEnum.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiModel_contents.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiModel_contents_list.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiObject.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiSession_instance.h"
    "/home/runner/work/stepcode/stepcode/include/cldai/sdaiString.h"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/runner/work/stepcode/stepcode/build_test/include/cldai/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
