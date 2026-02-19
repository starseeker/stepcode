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
  ${CMAKE_SOURCE_DIR}/include/stepcode
  )

set(_libdeps stepcore stepdai steputils stepeditor)

if(BUILD_SHARED_LIBS)
  SC_ADDLIB(steplazyfile SHARED SOURCES ${LAZY_SRCS} LINK_LIBRARIES ${_libdeps})
  if(WIN32)
    target_compile_definitions(steplazyfile PRIVATE SC_LAZYFILE_DLL_EXPORTS)
  endif()
endif()

if(BUILD_STATIC_LIBS)
  set(_libdeps stepcore-static stepdai-static steputils-static stepeditor-static)
  SC_ADDLIB(steplazyfile-static STATIC SOURCES ${LAZY_SRCS} LINK_LIBRARIES ${_libdeps})
endif()

# Prefer shared libs when both are enabled; fall back to static when shared is off
if(BUILD_SHARED_LIBS)
  SC_ADDEXEC(lazy_test SOURCES "lazy_test.cc;sc_benchmark.cc" LINK_LIBRARIES steplazyfile stepeditor TESTABLE)
elseif(BUILD_STATIC_LIBS)
  SC_ADDEXEC(lazy_test SOURCES "lazy_test.cc;sc_benchmark.cc" LINK_LIBRARIES steplazyfile-static stepeditor-static TESTABLE)
endif()
if(TARGET lazy_test)
  target_compile_definitions(lazy_test PRIVATE NO_REGISTRY)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

