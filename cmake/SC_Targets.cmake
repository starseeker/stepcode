function(SC_ADDEXEC execname)
  set(_opts NO_INSTALL TESTABLE)
  set(_multikw SOURCES LINK_LIBRARIES)
  cmake_parse_arguments(_SC_ADDEXEC "${_opts}" "" "${_multikw}" ${ARGN})

  if(NOT DEFINED _SC_ADDEXEC_SOURCES)
    message(SEND_ERROR "SC_ADDEXEC: SOURCES is required (target: ${execname})")
  endif()

  add_executable(${execname} ${_SC_ADDEXEC_SOURCES})

  if(DEFINED _SC_ADDEXEC_LINK_LIBRARIES)
    foreach(_lib ${_SC_ADDEXEC_LINK_LIBRARIES})
      if(SC_STATIC_UTILS)
        if(TARGET ${_lib})
          get_target_property(_lib_type ${_lib} TYPE)
          if(NOT "${_lib_type}" STREQUAL "STATIC_LIBRARY")
            message(SEND_ERROR "SC_ADDEXEC: expected static library target '${_lib}'")
          endif()
        endif()
      endif()
      target_link_libraries(${execname} ${_lib})
    endforeach()
  endif()

  if(NOT _SC_ADDEXEC_NO_INSTALL AND NOT _SC_ADDEXEC_TESTABLE)
    install(TARGETS ${execname}
      RUNTIME DESTINATION ${BIN_DIR}
      LIBRARY DESTINATION ${LIB_DIR}
      ARCHIVE DESTINATION ${LIB_DIR}
    )
  endif()

  if(NOT SC_ENABLE_TESTING AND _SC_ADDEXEC_TESTABLE)
    set_target_properties(${execname} PROPERTIES EXCLUDE_FROM_ALL ON)
  endif()
endfunction()

function(SC_ADDLIB _addlib_target)
  set(_opts SHARED STATIC NO_INSTALL TESTABLE)
  set(_multikw SOURCES LINK_LIBRARIES)
  cmake_parse_arguments(_SC_ADDLIB "${_opts}" "" "${_multikw}" ${ARGN})

  if(NOT DEFINED _SC_ADDLIB_SOURCES)
    message(SEND_ERROR "SC_ADDLIB: SOURCES is required (target: ${_addlib_target})")
  endif()

  if(_SC_ADDLIB_SHARED)
    add_library(${_addlib_target} SHARED ${_SC_ADDLIB_SOURCES})
    if(OPENBSD)
      set_target_properties(${_addlib_target} PROPERTIES
        VERSION ${SC_VERSION_MAJOR}.${SC_VERSION_MINOR})
    else()
      set_target_properties(${_addlib_target} PROPERTIES
        VERSION ${SC_VERSION} SOVERSION ${SC_VERSION_MAJOR})
    endif()
    if(APPLE)
      set_target_properties(${_addlib_target} PROPERTIES
        LINK_FLAGS "-flat_namespace -undefined suppress")
    endif()
  elseif(_SC_ADDLIB_STATIC)
    add_library(${_addlib_target} STATIC ${_SC_ADDLIB_SOURCES})
    target_compile_definitions(${_addlib_target} PRIVATE SC_STATIC)
  else()
    message(SEND_ERROR "SC_ADDLIB: either SHARED or STATIC is required (target: ${_addlib_target})")
  endif()

  if(DEFINED _SC_ADDLIB_LINK_LIBRARIES)
    foreach(_lib ${_SC_ADDLIB_LINK_LIBRARIES})
      if(_SC_ADDLIB_STATIC AND TARGET ${_lib})
        get_property(_libtype TARGET ${_lib} PROPERTY TYPE)
        if(NOT "${_libtype}" STREQUAL "STATIC_LIBRARY")
          message(SEND_ERROR "SC_ADDLIB: expected static library target '${_lib}'")
        endif()
      endif()
      target_link_libraries(${_addlib_target} ${_lib})
    endforeach()
  endif()

  if(NOT _SC_ADDLIB_NO_INSTALL AND NOT _SC_ADDLIB_TESTABLE)
    install(TARGETS ${_addlib_target}
      EXPORT stepcode-targets
      RUNTIME DESTINATION ${BIN_DIR}
      LIBRARY DESTINATION ${LIB_DIR}
      ARCHIVE DESTINATION ${LIB_DIR}
    )
  endif()
endfunction()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

