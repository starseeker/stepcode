set(UTILS_SRCS
  Str.cc
  dirobj.cc
  gennode.cc
  gennodelist.cc
  gennodearray.cc
  sc_hash.cc
  errordesc.cc
  )

include_directories(
  ${PROJECT_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}
)

if(BUILD_SHARED_LIBS)
  add_library(steputils SHARED ${UTILS_SRCS})
  set_target_properties(steputils PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
  )
  if(WIN32)
    target_compile_definitions(steputils PRIVATE SC_UTILS_DLL_EXPORTS)
    target_link_libraries(steputils shlwapi)
  endif()
  install(TARGETS steputils
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  add_library(steputils-static STATIC ${UTILS_SRCS})
  target_compile_definitions(steputils-static PRIVATE SC_STATIC)
  if(WIN32)
    target_link_libraries(steputils-static shlwapi)
  endif()
  install(TARGETS steputils-static
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

