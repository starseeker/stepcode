# create config.h

include(CheckLibraryExists)
include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckTypeSize)

CHECK_INCLUDE_FILE(ndir.h HAVE_NDIR_H)
CHECK_INCLUDE_FILE(stdarg.h HAVE_STDARG_H)
CHECK_INCLUDE_FILE(stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILE(sys/stat.h HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILE(sys/param.h HAVE_SYS_PARAM_H)
CHECK_INCLUDE_FILE(sysent.h HAVE_SYSENT_H)
CHECK_INCLUDE_FILE(unistd.h HAVE_UNISTD_H)
CHECK_INCLUDE_FILE(dirent.h HAVE_DIRENT_H)
CHECK_INCLUDE_FILE(stdbool.h HAVE_STDBOOL_H)
CHECK_INCLUDE_FILE(process.h HAVE_PROCESS_H)
CHECK_INCLUDE_FILE(io.h HAVE_IO_H)

# ensure macro functions are captured
CHECK_SYMBOL_EXISTS(abs "stdlib.h" HAVE_ABS)
CHECK_SYMBOL_EXISTS(memcpy "string.h" HAVE_MEMCPY)
CHECK_SYMBOL_EXISTS(memmove "string.h" HAVE_MEMMOVE)
CHECK_SYMBOL_EXISTS(getopt "getopt.h" HAVE_GETOPT)
CHECK_SYMBOL_EXISTS(vsnprintf "stdio.h" HAVE_VSNPRINTF)

CHECK_TYPE_SIZE("ssize_t" SSIZE_T)

# Now that all the tests are done, configure the config.h file:
configure_file(${CMAKE_SOURCE_DIR}/include/config.h.in ${SC_BINARY_DIR}/${INCLUDE_DIR}/config.h.gen)
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SC_BINARY_DIR}/${INCLUDE_DIR}/config.h.gen ${SC_BINARY_DIR}/${INCLUDE_DIR}/config.h)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

