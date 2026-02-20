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

if(BUILD_SHARED_LIBS)
  add_library(stepdai SHARED ${DAI_SRCS})
  if(OPENBSD)
    set_target_properties(stepdai PROPERTIES
      VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
  else()
    set_target_properties(stepdai PROPERTIES
      VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
  endif()
  if(APPLE)
    set_target_properties(stepdai PROPERTIES
      LINK_FLAGS "-flat_namespace -undefined suppress")
  endif()
  target_include_directories(stepdai
    PUBLIC
      $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
      $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
      $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
  )
  target_link_libraries(stepdai steputils)
  if(WIN32)
    target_compile_definitions(stepdai PRIVATE SC_DAI_DLL_EXPORTS)
  endif()
  install(TARGETS stepdai
    EXPORT stepcode-targets
    RUNTIME DESTINATION ${BIN_DIR}
    LIBRARY DESTINATION ${LIB_DIR}
    ARCHIVE DESTINATION ${LIB_DIR}
  )
endif()

if(BUILD_STATIC_LIBS)
  SC_ADDLIB(stepdai-static STATIC SOURCES ${DAI_SRCS} LINK_LIBRARIES steputils-static)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

