set(DAI_SRCS
  sdaiApplication_instance_set.cc
  sdaiBinary.cc
  sdaiDaObject.cc
  sdaiEntity_extent.cc
  sdaiEntity_extent_set.cc
  sdaiEnum.cc
  sdaiModel_contents.cc
  sdaiModel_contents_list.cc
  sdaiObject.cc
  sdaiSession_instance.cc
  sdaiString.cc
  )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include/stepcode
  )

SC_ADDLIB(stepdai SOURCES ${DAI_SRCS} LINK_LIBRARIES steputils DLL_EXPORTS SC_DAI_DLL_EXPORTS)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

