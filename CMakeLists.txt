#    C M A K E L I S T S . T X T   F O R   S T E P C O D E
#
# This file is Copyright (c) 2010 United States Government as
# represented by the U.S. Army Research Laboratory.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following
# disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. The name of the author may not be used to endorse or promote
# products derived from this software without specific prior written
# permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
# OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# *******************************************************************
# ***                 STEPcode's CMakeLists.txt                   ***
# *******************************************************************

# This file contains the top level CMakeLists.txt logic for the
# STEPcode software package.

# Minimum required version of CMake
cmake_minimum_required(VERSION 3.20)

# Modern CMake policies
cmake_policy(SET CMP0077 NEW)  # option() honors normal variables

project(SC
  VERSION 0.9.1
  LANGUAGES C CXX
  DESCRIPTION "STEPcode - STEP file tools and libraries"
)

# Version information is defined in project() command above

# Set language standards
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# CMake derives much of its functionality from modules, typically
# stored in one directory - let CMake know where to find them.
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# Use standard GNU installation directories
include(GNUInstallDirs)

# OpenBSD has its own naming conventions.  Set a platform variable based on
# the OS name so we can test for it succinctly.
if(CMAKE_SYSTEM_NAME MATCHES "OpenBSD")
  set(OPENBSD ON)
endif()

#---------------------------------------------------------------------
# Set up output directories for build artifacts
if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}")
endif()
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
endif()
if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
endif()

# For compatibility with legacy code that references these variables
set(BIN_DIR "${CMAKE_INSTALL_BINDIR}")
set(LIB_DIR "${CMAKE_INSTALL_LIBDIR}")
set(INCLUDE_DIR "${CMAKE_INSTALL_INCLUDEDIR}")
set(DATA_DIR "${CMAKE_INSTALL_DATADIR}")
set(DOC_DIR "${CMAKE_INSTALL_DOCDIR}")
set(MAN_DIR "${CMAKE_INSTALL_MANDIR}")

#---------------------------------------------------------------------
# RPATH handling for proper runtime linking in build and install trees

# Use RPATH in build tree
set(CMAKE_SKIP_BUILD_RPATH FALSE)

# Don't use install RPATH during build
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)

# Add automatically determined parts of RPATH
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# Set install RPATH
if(APPLE)
  set(CMAKE_INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
else()
  set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}:\$ORIGIN/../${CMAKE_INSTALL_LIBDIR}")
endif()


#---------------------------------------------------------------------
# Build options
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_STATIC_LIBS "Build static libraries" OFF)

option(SC_PYTHON_GENERATOR "Compile exp2python" ON)
option(SC_CPP_GENERATOR "Compile exp2cxx" ON)

option(SC_TRACE_FPRINTF "Enable extra comments in generated code so the code's source in exp2cxx may be located" OFF)

option(SC_ENABLE_COVERAGE "Enable code coverage test" OFF)
if(SC_ENABLE_COVERAGE AND CMAKE_C_COMPILER_ID STREQUAL "GNU")
  set(CMAKE_C_FLAGS_DEBUG "-O0 -g -fprofile-arcs -ftest-coverage" CACHE STRING "Extra compile flags required by code coverage" FORCE)
  set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -fprofile-arcs -ftest-coverage" CACHE STRING "Extra compile flags required by code coverage" FORCE)
  set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "-fprofile-arcs -ftest-coverage" CACHE STRING "Extra linker flags required by code coverage" FORCE)
endif()

option(SC_BUILD_EXPRESS_ONLY "Only build express parser." OFF)
mark_as_advanced(SC_BUILD_EXPRESS_ONLY)

option(SC_ENABLE_TESTING "Enable unittesting framework" OFF)
if(SC_ENABLE_TESTING)
  if(NOT "${SC_BUILD_EXPRESS_ONLY}" AND NOT DEFINED SC_BUILD_SCHEMAS)
    set(SC_BUILD_SCHEMAS "ALL") #test all schemas, unless otherwise specified
  endif()
  include(CTest)
endif(SC_ENABLE_TESTING)

# SC_ADDEXEC and SC_ADDLIB macros, dllimport/export, etc
include(SC_Targets)

# Macros related to paths
include(SC_Paths)

# locale stuff
include(SC_Locale)

# logic related to regenerating the lexer and parser source code
include(SC_Regenerate)

# create config.h header
include(SC_Config_Headers)

if(NOT DEFINED SC_SDAI_ADDITIONAL_EXES_SRCS)
  set(SC_SDAI_ADDITIONAL_EXES_SRCS "" CACHE STRING "Source files for additional executables to be linked with SDAI libs")
endif()

if(NOT SC_BUILD_EXPRESS_ONLY AND NOT DEFINED SC_BUILD_SCHEMAS)
  list(APPEND CONFIG_END_MESSAGES
    "** Note: CMake variable SC_BUILD_SCHEMAS was not set - defaults to building ALL schemas")
  # this makes SC_BUILD_SCHEMAS show up in cmake-gui
  set(SC_BUILD_SCHEMAS "ALL" CACHE STRING "Semicolon-separated list of paths to EXPRESS schemas to be built")
endif()

# Status messages to print at the end
list(APPEND CONFIG_END_MESSAGES
  ".. Don't worry about any messages above about missing headers or failed tests, as long as"
  "    you see 'Configuring done' below. Headers and features vary by compiler."
  ".. Generating step can take a while if you are building several schemas.")

################

if(MSVC)
  # Disable warning for preferred usage of secure functions
  add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_WARNINGS)
endif()
if(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
  add_compile_options(-pedantic -W -Wall -Wundef -Wfloat-equal -Wshadow -Winline -Wno-long-long)
endif()

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_BINARY_DIR}/include
)

add_subdirectory(src/express)
add_subdirectory(src/exppp)
add_subdirectory(src/exp2cxx)
add_subdirectory(src/exp2python)
add_subdirectory(src/clstepcore)
add_subdirectory(src/cleditor)
add_subdirectory(src/cldai)
add_subdirectory(src/clutils)
add_subdirectory(src/cllazyfile)
add_subdirectory(include)
add_subdirectory(data)
if(SC_ENABLE_TESTING)
  add_subdirectory(test)
endif(SC_ENABLE_TESTING)
add_subdirectory(doc)

#-----------------------------------------------------------------------------
# Packaging configuration
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "STEPcode - STEP file tools and libraries")
set(CPACK_SET_DESTDIR "ON")
set(CPACK_PACKAGE_VERSION_MAJOR ${SC_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${SC_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${SC_VERSION_PATCH})
set(CPACK_PACKAGE_NAME SC)
set(CPACK_PACKAGE_CONTACT "SC Developers <scl-dev@googlegroups.com>")
include(CPack)


# CONFIG_END_MESSAGES - list of messages to be printed after everything else is done.
# THIS MUST BE LAST to ensure that they are visible to the user without scrolling.
foreach(_msg ${CONFIG_END_MESSAGES})
  message(STATUS "${_msg}")
endforeach(_msg ${CONFIG_END_MESSAGES})

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

