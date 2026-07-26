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

SC_ADDLIB(libexppp SOURCES ${LIBEXPPP_SOURCES} LINK_LIBRARIES express DLL_EXPORTS SC_EXPPP_DLL_EXPORTS)
if(TARGET libexppp)
  set_target_properties(libexppp PROPERTIES PREFIX "")
endif()
if(TARGET libexppp-static)
  set_target_properties(libexppp-static PROPERTIES PREFIX "")
endif()

SC_ADDEXEC(exppp SOURCES ${EXPPP_SOURCES} LINK_LIBRARIES libexppp${SC_LIB_SUFFIX} express${SC_LIB_SUFFIX})

if(SC_ENABLE_TESTING)
  add_subdirectory(test)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

