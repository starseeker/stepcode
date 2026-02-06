# Install script for directory: /home/runner/work/stepcode/stepcode/include

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
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/stepcode/express" TYPE FILE FILES
    "/home/runner/work/stepcode/stepcode/include/express/alg.h"
    "/home/runner/work/stepcode/stepcode/include/express/basic.h"
    "/home/runner/work/stepcode/stepcode/include/express/caseitem.h"
    "/home/runner/work/stepcode/stepcode/include/express/dict.h"
    "/home/runner/work/stepcode/stepcode/include/express/entity.h"
    "/home/runner/work/stepcode/stepcode/include/express/error.h"
    "/home/runner/work/stepcode/stepcode/include/express/expbasic.h"
    "/home/runner/work/stepcode/stepcode/include/express/expr.h"
    "/home/runner/work/stepcode/stepcode/include/express/express.h"
    "/home/runner/work/stepcode/stepcode/include/express/hash.h"
    "/home/runner/work/stepcode/stepcode/include/express/lexact.h"
    "/home/runner/work/stepcode/stepcode/include/express/linklist.h"
    "/home/runner/work/stepcode/stepcode/include/express/memory.h"
    "/home/runner/work/stepcode/stepcode/include/express/object.h"
    "/home/runner/work/stepcode/stepcode/include/express/resolve.h"
    "/home/runner/work/stepcode/stepcode/include/express/schema.h"
    "/home/runner/work/stepcode/stepcode/include/express/scope.h"
    "/home/runner/work/stepcode/stepcode/include/express/stmt.h"
    "/home/runner/work/stepcode/stepcode/include/express/symbol.h"
    "/home/runner/work/stepcode/stepcode/include/express/type.h"
    "/home/runner/work/stepcode/stepcode/include/express/variable.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/stepcode/exppp" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/include/exppp/exppp.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/stepcode" TYPE FILE FILES
    "/home/runner/work/stepcode/stepcode/include/ordered_attrs.h"
    "/home/runner/work/stepcode/stepcode/include/sc_export.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/stepcode" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build-test-final/include/config.h")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/runner/work/stepcode/stepcode/build-test-final/include/cldai/cmake_install.cmake")
  include("/home/runner/work/stepcode/stepcode/build-test-final/include/cleditor/cmake_install.cmake")
  include("/home/runner/work/stepcode/stepcode/build-test-final/include/cllazyfile/cmake_install.cmake")
  include("/home/runner/work/stepcode/stepcode/build-test-final/include/clstepcore/cmake_install.cmake")
  include("/home/runner/work/stepcode/stepcode/build-test-final/include/clutils/cmake_install.cmake")

endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/runner/work/stepcode/stepcode/build-test-final/include/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
