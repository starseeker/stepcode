set(LIBEXPPP_SOURCES
  exppp.c
  pretty_alg.c
  pretty_case.c
  pretty_entity.c
  pretty_expr.cc
  pretty_express.c
  pretty_func.c
  pretty_loop.c
  pretty_proc.c
  pretty_ref.c
  pretty_rule.c
  pretty_schema.c
  pretty_scope.c
  pretty_stmt.c
  pretty_subtype.c
  pretty_type.c
  pretty_where.c
 )

SET(EXPPP_SOURCES
  ../express/fedex.c
  exppp-main.c
 )

include_directories(
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/include/exppp
  ${PROJECT_SOURCE_DIR}/src/express
)

if(BUILD_SHARED_LIBS)
  add_library(libexppp SHARED ${LIBEXPPP_SOURCES})
  if(OPENBSD)
    set_target_properties(libexppp PROPERTIES
      PREFIX ""
      VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
  else()
    set_target_properties(libexppp PROPERTIES
      PREFIX ""
      VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
  endif()
  if(APPLE)
    set_target_properties(libexppp PROPERTIES
      LINK_FLAGS "-flat_namespace -undefined suppress")
  endif()
  target_include_directories(libexppp
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(libexppp express)
  if(WIN32)
    target_compile_definitions(libexppp PRIVATE SC_EXPPP_DLL_EXPORTS)
  endif()
  install(TARGETS libexppp
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  add_library(libexppp-static STATIC ${LIBEXPPP_SOURCES})
  set_target_properties(libexppp-static PROPERTIES PREFIX "")
  target_compile_definitions(libexppp-static PRIVATE SC_STATIC)
  target_include_directories(libexppp-static
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(libexppp-static express-static)
  install(TARGETS libexppp-static
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_SHARED_LIBS)
  SC_ADDEXEC(exppp SOURCES ${EXPPP_SOURCES} LINK_LIBRARIES libexppp express)
else()
  SC_ADDEXEC(exppp SOURCES ${EXPPP_SOURCES} LINK_LIBRARIES libexppp-static express-static)
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

