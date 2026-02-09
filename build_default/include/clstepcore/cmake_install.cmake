# Install script for directory: /home/runner/work/stepcode/stepcode/include/clstepcore

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/stepcode/clstepcore" TYPE FILE FILES
    "/home/runner/work/stepcode/stepcode/include/clstepcore/aggrTypeDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/attrDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/attrDescriptorList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/baseType.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/complexSupport.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/create_Aggr.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/derivedAttribute.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/dictSchema.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/dictdefs.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/dictionaryInstance.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/dispnode.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/dispnodelist.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/entityDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/entityDescriptorList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/enumTypeDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/ExpDict.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/explicitItemId.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/globalRule.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/implicitItemId.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/instmgr.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/interfaceSpec.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/interfacedItem.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/inverseAttribute.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/inverseAttributeList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/mgrnode.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/mgrnodearray.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/mgrnodelist.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/needFunc.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/read_func.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/realTypeDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/Registry.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/schRename.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/sdai.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/sdaiApplication_instance.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/sdaiSelect.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/selectTypeDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/SingleLinkList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggregate.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrBinary.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrEntity.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrEnum.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrGeneric.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrInt.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrReal.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrSelect.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPaggrString.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPattribute.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPattributeList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPcomplex.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPinvAttrList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/STEPundefined.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/stringTypeDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/SubSuperIterators.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/typeDescriptor.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/typeDescriptorList.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/typeOrRuleVar.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/uniquenessRule.h"
    "/home/runner/work/stepcode/stepcode/include/clstepcore/whereRule.h"
    )
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/runner/work/stepcode/stepcode/build_default/include/clstepcore/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
