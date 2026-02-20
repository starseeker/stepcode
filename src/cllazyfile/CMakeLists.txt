set(LAZY_SRCS
  lazyDataSectionReader.cc
  lazyFileReader.cc
  lazyInstMgr.cc
  p21HeaderSectionReader.cc
  sectionReader.cc
  lazyP21DataSectionReader.cc
  judy.c
  )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include/stepcode
  )

SC_ADDLIB(steplazyfile SOURCES ${LAZY_SRCS} LINK_LIBRARIES stepcore stepdai steputils stepeditor DLL_EXPORTS SC_LAZYFILE_DLL_EXPORTS)

SC_ADDEXEC(lazy_test SOURCES "lazy_test.cc;sc_benchmark.cc" LINK_LIBRARIES steplazyfile${SC_LIB_SUFFIX} stepeditor${SC_LIB_SUFFIX} TESTABLE)
target_compile_definitions(lazy_test PRIVATE NO_REGISTRY)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

