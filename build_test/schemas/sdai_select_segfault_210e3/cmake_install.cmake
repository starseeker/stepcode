# Install script for directory: /home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiBinary_numeric_expression.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDate_and_time.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiRepresentation.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiBoolean_literal.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiRow_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiLiteral_number.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDate_time_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiSlash_expression.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiTable_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiLogical_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiMeasure_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiRational_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiValue_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiReal_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiRepresentation_context.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiPoint_and_vector.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiMapped_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDerived_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiCartesian_point.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiPoint_path.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiInteger_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiPlane_angle_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiReal_literal.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiBinary_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDate_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiBinary_generic_expression.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiRepresentation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiMeasure_with_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDate.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiConversion_based_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDimensional_exponents.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiNumeric_expression.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiInt_literal.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiSi_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiPlane_angle_measure_with_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiLogical_literal.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiPoint.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiDirection.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiGeneric_expression.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiRepresentation_map.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiStyled_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiGeometric_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiBoolean_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiCompound_representation_item.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/entity" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/entity/SdaiNamed_unit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/type" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/type/SdaiPoint_and_vector_member.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/type" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/type/SdaiSi_prefix_var.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/type" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/type/SdaiMeasure_value.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/type" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/type/SdaiSi_unit_name_var.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/type" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/type/SdaiUnit.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3/type" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/type/SdaiCompound_item_definition.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/Sdaiclasses.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/schema.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/SdaiSELECT_SEGFAULT_210E3Names.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/schemas/sdai_select_segfault_210e3" TYPE FILE FILES "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/SdaiSELECT_SEGFAULT_210E3.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdai_select_segfault_210e3.so.0.9.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdai_select_segfault_210e3.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/usr/local/lib:$ORIGIN/../lib")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/home/runner/work/stepcode/stepcode/build_test/lib/libsdai_select_segfault_210e3.so.0.9.1"
    "/home/runner/work/stepcode/stepcode/build_test/lib/libsdai_select_segfault_210e3.so.0"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdai_select_segfault_210e3.so.0.9.1"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libsdai_select_segfault_210e3.so.0"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/runner/work/stepcode/stepcode/build_test/lib:"
           NEW_RPATH "/usr/local/lib:$ORIGIN/../lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/runner/work/stepcode/stepcode/build_test/lib/libsdai_select_segfault_210e3.so")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/runner/work/stepcode/stepcode/build_test/schemas/sdai_select_segfault_210e3/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
