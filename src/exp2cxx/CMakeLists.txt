set(FEDEX_COMMON_SRCS
  classes_misc.c
  ../express/fedex.c
  )

set(exp2cxx_SOURCES
  ${FEDEX_COMMON_SRCS}
  trace_fprintf.c
  fedex_main.c
  classes_wrapper.cc
  classes.c
  classes_attribute.c
  classes_entity.c
  classes_type.c
  class_strings.c
  selects.c
  multpass.c
  rules.c
  collect.cc
  complexlist.cc
  entlist.cc
  multlist.cc
  orlist.cc
  entnode.cc
  expressbuild.cc
  non-ors.cc
  match-ors.cc
  trynext.cc
  write.cc
  print.cc
  genCxxFilenames.c
  )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/include/exppp
  ${PROJECT_SOURCE_DIR}/include/express
)

if(BUILD_SHARED_LIBS)
  add_executable(exp2cxx ${exp2cxx_SOURCES})
  target_link_libraries(exp2cxx libexppp express)
  install(TARGETS exp2cxx
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
elseif(BUILD_STATIC_LIBS)
  add_executable(exp2cxx ${exp2cxx_SOURCES})
  target_link_libraries(exp2cxx libexppp-static express-static)
  install(TARGETS exp2cxx
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
endif()

if(SC_ENABLE_TESTING)
  add_subdirectory(test)
endif(SC_ENABLE_TESTING)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

