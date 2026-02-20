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
  set_target_properties(stepeditor PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
  )
  target_link_libraries(stepeditor stepcore stepdai steputils)
  if(WIN32)
    target_compile_definitions(stepeditor PRIVATE SC_EDITOR_DLL_EXPORTS)
  endif()
  install(TARGETS stepeditor
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  add_library(stepeditor-static STATIC ${EDITOR_SRCS})
  target_compile_definitions(stepeditor-static PRIVATE SC_STATIC)
  target_link_libraries(stepeditor-static stepcore-static stepdai-static steputils-static)
  install(TARGETS stepeditor-static
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

