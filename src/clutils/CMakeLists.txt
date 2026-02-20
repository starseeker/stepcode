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

SC_ADDLIB(steputils SOURCES ${UTILS_SRCS} DLL_EXPORTS SC_UTILS_DLL_EXPORTS)
if(WIN32)
  if(TARGET steputils)
    target_link_libraries(steputils shlwapi)
  endif()
  if(TARGET steputils-static)
    target_link_libraries(steputils-static shlwapi)
  endif()
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

