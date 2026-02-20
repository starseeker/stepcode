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

if(BUILD_SHARED_LIBS)
  add_library(steplazyfile SHARED ${LAZY_SRCS})
  if(OPENBSD)
    set_target_properties(steplazyfile PROPERTIES
      VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
  else()
    set_target_properties(steplazyfile PROPERTIES
      VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
  endif()
  if(APPLE)
    set_target_properties(steplazyfile PROPERTIES
      LINK_FLAGS "-flat_namespace -undefined suppress")
  endif()
  target_include_directories(steplazyfile
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(steplazyfile stepcore stepdai steputils stepeditor)
  if(WIN32)
    target_compile_definitions(steplazyfile PRIVATE SC_LAZYFILE_DLL_EXPORTS)
  endif()
  install(TARGETS steplazyfile
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  add_library(steplazyfile-static STATIC ${LAZY_SRCS})
  target_compile_definitions(steplazyfile-static PRIVATE SC_STATIC)
  target_include_directories(steplazyfile-static
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(steplazyfile-static stepcore-static stepdai-static steputils-static stepeditor-static)
  install(TARGETS steplazyfile-static
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
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

