set(CORE_SRCS
  aggrTypeDescriptor.cc
  attrDescriptor.cc
  attrDescriptorList.cc
  collect.cc
  complexlist.cc
  create_Aggr.cc
  derivedAttribute.cc
  dictSchema.cc
  dispnode.cc
  dispnodelist.cc
  entityDescriptor.cc
  entityDescriptorList.cc
  entlist.cc
  entnode.cc
  enumTypeDescriptor.cc
  explicitItemId.cc
  globalRule.cc
  implicitItemId.cc
  instmgr.cc
  interfaceSpec.cc
  interfacedItem.cc
  inverseAttribute.cc
  inverseAttributeList.cc
  match-ors.cc
  mgrnode.cc
  mgrnodearray.cc
  mgrnodelist.cc
  multlist.cc
  needFunc.cc
  non-ors.cc
  orlist.cc
  print.cc
  read_func.cc
  Registry.cc
  schRename.cc
  sdai.cc
  sdaiApplication_instance.cc
  sdaiSelect.cc
  selectTypeDescriptor.cc
  SingleLinkList.cc
  STEPaggregate.cc
  STEPaggrBinary.cc
  STEPaggrEntity.cc
  STEPaggrEnum.cc
  STEPaggrGeneric.cc
  STEPaggrInt.cc
  STEPaggrReal.cc
  STEPaggrSelect.cc
  STEPaggrString.cc
  STEPattribute.cc
  STEPattributeList.cc
  STEPcomplex.cc
  STEPinvAttrList.cc
  STEPundefined.cc
  trynext.cc
  typeDescriptor.cc
  typeDescriptorList.cc
  typeOrRuleVar.cc
  uniquenessRule.cc
  whereRule.cc
)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include/stepcode
)

if(BUILD_SHARED_LIBS)
  add_library(stepcore SHARED ${CORE_SRCS})
  if(OPENBSD)
    set_target_properties(stepcore PROPERTIES
      VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
  else()
    set_target_properties(stepcore PROPERTIES
      VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
  endif()
  if(APPLE)
    set_target_properties(stepcore PROPERTIES
      LINK_FLAGS "-flat_namespace -undefined suppress")
  endif()
  target_include_directories(stepcore
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(stepcore steputils stepdai)
  if(WIN32)
    target_compile_definitions(stepcore PRIVATE SC_CORE_DLL_EXPORTS)
  endif()
  install(TARGETS stepcore
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  SC_ADDLIB(stepcore-static STATIC SOURCES ${CORE_SRCS} LINK_LIBRARIES steputils-static stepdai-static)
endif()

if(SC_ENABLE_TESTING)
  add_subdirectory(test)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

