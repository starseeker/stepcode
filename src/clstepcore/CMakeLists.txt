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

SC_ADDLIB(stepcore SOURCES ${CORE_SRCS} LINK_LIBRARIES steputils stepdai DLL_EXPORTS SC_CORE_DLL_EXPORTS)

if(SC_ENABLE_TESTING)
  add_subdirectory(test)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

