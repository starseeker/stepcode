#
# CMakeLists.txt for AP203 Minimum
#
#  This file is released to the public domain.  Any part of this file may be
# freely copied in part or in full for any purpose.  No acknowledgment is required
# for the use of this file.
#
cmake_minimum_required(VERSION 3.12)
project(AP203Minimum)

find_package(STEPCODE CONFIG REQUIRED)

add_executable(${PROJECT_NAME} ap203min.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE
  STEPCODE::stepeditor STEPCODE::stepcore STEPCODE::stepdai STEPCODE::steputils
  STEPCODE::sdai_ap203)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

