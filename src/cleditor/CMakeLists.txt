set(EDITOR_SRCS
  STEPfile.cc
  STEPfile.inline.cc
  cmdmgr.cc
  SdaiHeaderSchema.cc
  SdaiHeaderSchemaAll.cc
  SdaiHeaderSchemaInit.cc
  SdaiSchemaInit.cc
  )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include/stepcode
)

if(BUILD_SHARED_LIBS)
  add_library(stepeditor SHARED ${EDITOR_SRCS})
  if(OPENBSD)
    set_target_properties(stepeditor PROPERTIES
      VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
  else()
    set_target_properties(stepeditor PROPERTIES
      VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
  endif()
  if(APPLE)
    set_target_properties(stepeditor PROPERTIES
      LINK_FLAGS "-flat_namespace -undefined suppress")
  endif()
  target_include_directories(stepeditor
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(stepeditor stepcore stepdai steputils)
  if(WIN32)
    target_compile_definitions(stepeditor PRIVATE SC_EDITOR_DLL_EXPORTS)
  endif()
  install(TARGETS stepeditor
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  add_library(stepeditor-static STATIC ${EDITOR_SRCS})
  target_compile_definitions(stepeditor-static PRIVATE SC_STATIC)
  target_include_directories(stepeditor-static
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(stepeditor-static stepcore-static stepdai-static steputils-static)
  install(TARGETS stepeditor-static
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

