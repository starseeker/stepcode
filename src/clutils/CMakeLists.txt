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
  if(OPENBSD)
    set_target_properties(steputils PROPERTIES
      VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
  else()
    set_target_properties(steputils PROPERTIES
      VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
  endif()
  if(APPLE)
    set_target_properties(steputils PROPERTIES
      LINK_FLAGS "-flat_namespace -undefined suppress")
  endif()
  target_include_directories(steputils
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  if(WIN32)
    target_compile_definitions(steputils PRIVATE SC_UTILS_DLL_EXPORTS)
    target_link_libraries(steputils shlwapi)
  endif()
  install(TARGETS steputils
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  add_library(steputils-static STATIC ${UTILS_SRCS})
  target_compile_definitions(steputils-static PRIVATE SC_STATIC)
  target_include_directories(steputils-static
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  if(WIN32)
    target_link_libraries(steputils-static shlwapi)
  endif()
  install(TARGETS steputils-static
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

