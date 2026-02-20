function(SC_ADDEXEC execname)
  set(_opts NO_INSTALL TESTABLE)
  set(_multikw SOURCES LINK_LIBRARIES)
  cmake_parse_arguments(_SC_ADDEXEC "${_opts}" "" "${_multikw}" ${ARGN})

  if(NOT DEFINED _SC_ADDEXEC_SOURCES)
    message(SEND_ERROR "SC_ADDEXEC: SOURCES is required (target: ${execname})")
  endif()

  add_executable(${execname} ${_SC_ADDEXEC_SOURCES})

  if(_SC_ADDEXEC_LINK_LIBRARIES)
    target_link_libraries(${execname} ${_SC_ADDEXEC_LINK_LIBRARIES})
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

# SC_ADDLIB - create a shared library, a static library, or both.
#
# Usage:
#   SC_ADDLIB(<target> SOURCES <files...>
#             [LINK_LIBRARIES <libs...>]
#             [SHARED|STATIC]
#             [DLL_EXPORTS <define>]
#             [NO_INSTALL] [TESTABLE])
#
# When called without SHARED or STATIC (auto mode), both variants are created
# based on the BUILD_SHARED_LIBS and BUILD_STATIC_LIBS cache options.  The
# shared target is named <target> and the static target is named <target>-static.
# LINK_LIBRARIES names are used as-is for the shared variant; "-static" is
# appended to each name for the static variant.
#
# DLL_EXPORTS <define>  - on WIN32, add <define> as a PRIVATE compile definition
#                         to the shared target (marks symbols as dllexport).
#                         Static builds use SC_STATIC instead.
#
# SHARED or STATIC may still be passed explicitly for special cases (e.g. when
# the caller must control the exact name or link libraries of each variant).
# In explicit STATIC mode each LINK_LIBRARIES entry is validated to be a static
# library target.
function(SC_ADDLIB _addlib_target)
  set(_opts SHARED STATIC NO_INSTALL TESTABLE)
  set(_singlekw DLL_EXPORTS)
  set(_multikw SOURCES LINK_LIBRARIES)
  cmake_parse_arguments(_SC_ADDLIB "${_opts}" "${_singlekw}" "${_multikw}" ${ARGN})

  if(NOT DEFINED _SC_ADDLIB_SOURCES)
    message(SEND_ERROR "SC_ADDLIB: SOURCES is required (target: ${_addlib_target})")
  endif()

  if(_SC_ADDLIB_SHARED)
    # --- Explicit SHARED mode ---
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
    if(WIN32 AND _SC_ADDLIB_DLL_EXPORTS)
      target_compile_definitions(${_addlib_target} PRIVATE ${_SC_ADDLIB_DLL_EXPORTS})
    endif()
    target_include_directories(${_addlib_target}
      PUBLIC
        $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
    )
    if(_SC_ADDLIB_LINK_LIBRARIES)
      target_link_libraries(${_addlib_target} ${_SC_ADDLIB_LINK_LIBRARIES})
    endif()
    if(NOT _SC_ADDLIB_NO_INSTALL AND NOT _SC_ADDLIB_TESTABLE)
      install(TARGETS ${_addlib_target}
        EXPORT stepcode-targets
        RUNTIME DESTINATION ${BIN_DIR}
        LIBRARY DESTINATION ${LIB_DIR}
        ARCHIVE DESTINATION ${LIB_DIR}
      )
    endif()

  elseif(_SC_ADDLIB_STATIC)
    # --- Explicit STATIC mode ---
    add_library(${_addlib_target} STATIC ${_SC_ADDLIB_SOURCES})
    target_compile_definitions(${_addlib_target} PRIVATE SC_STATIC)
    target_include_directories(${_addlib_target}
      PUBLIC
        $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
    )
    if(_SC_ADDLIB_LINK_LIBRARIES)
      foreach(_lib ${_SC_ADDLIB_LINK_LIBRARIES})
        if(TARGET ${_lib})
          get_property(_libtype TARGET ${_lib} PROPERTY TYPE)
          if(NOT ${_libtype} STREQUAL "STATIC_LIBRARY")
            message(SEND_ERROR "SC_ADDLIB usage error - expected (static) LINK_LIBRARIES targets (${_lib})")
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

  else()
    # --- Auto mode: create shared and/or static based on BUILD_* options ---
    set(_do_shared FALSE)
    set(_do_static FALSE)
    if(BUILD_SHARED_LIBS OR NOT BUILD_STATIC_LIBS)
      set(_do_shared TRUE)
    endif()
    if(BUILD_STATIC_LIBS)
      set(_do_static TRUE)
    endif()

    if(_do_shared)
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
      if(WIN32 AND _SC_ADDLIB_DLL_EXPORTS)
        target_compile_definitions(${_addlib_target} PRIVATE ${_SC_ADDLIB_DLL_EXPORTS})
      endif()
      target_include_directories(${_addlib_target}
        PUBLIC
          $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
          $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
          $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
      )
      if(_SC_ADDLIB_LINK_LIBRARIES)
        target_link_libraries(${_addlib_target} ${_SC_ADDLIB_LINK_LIBRARIES})
      endif()
      if(NOT _SC_ADDLIB_NO_INSTALL AND NOT _SC_ADDLIB_TESTABLE)
        install(TARGETS ${_addlib_target}
          EXPORT stepcode-targets
          RUNTIME DESTINATION ${BIN_DIR}
          LIBRARY DESTINATION ${LIB_DIR}
          ARCHIVE DESTINATION ${LIB_DIR}
        )
      endif()
    endif()

    if(_do_static)
      set(_static_tgt "${_addlib_target}-static")
      add_library(${_static_tgt} STATIC ${_SC_ADDLIB_SOURCES})
      target_compile_definitions(${_static_tgt} PRIVATE SC_STATIC)
      target_include_directories(${_static_tgt}
        PUBLIC
          $<BUILD_INTERFACE:${SC_SOURCE_DIR}/include>
          $<BUILD_INTERFACE:${SC_BINARY_DIR}/include>
          $<INSTALL_INTERFACE:${INCLUDE_DIR}/stepcode>
      )
      # Derive static deps: append "-static" to each shared link library name.
      # This relies on the convention that all SC library targets have a
      # corresponding <name>-static variant.  External system libraries should
      # be added via target_link_libraries() after calling SC_ADDLIB.
      if(_SC_ADDLIB_LINK_LIBRARIES)
        foreach(_lib ${_SC_ADDLIB_LINK_LIBRARIES})
          target_link_libraries(${_static_tgt} "${_lib}-static")
        endforeach()
      endif()
      if(NOT _SC_ADDLIB_NO_INSTALL AND NOT _SC_ADDLIB_TESTABLE)
        install(TARGETS ${_static_tgt}
          EXPORT stepcode-targets
          RUNTIME DESTINATION ${BIN_DIR}
          LIBRARY DESTINATION ${LIB_DIR}
          ARCHIVE DESTINATION ${LIB_DIR}
        )
      endif()
    endif()
  endif()
endfunction()

# SC_LIB_SUFFIX - suffix to append to SC library target names when linking.
# Empty when shared libraries are available; "-static" for static-only builds.
if(BUILD_SHARED_LIBS OR NOT BUILD_STATIC_LIBS)
  set(SC_LIB_SUFFIX "")
else()
  set(SC_LIB_SUFFIX "-static")
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

