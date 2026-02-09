# -----  GENERATED FILE  -----
# -----   Do not edit!   -----

# schema name: test_inverse_attr
# (short name: sdai_inverse_attr)
# 3 entities, 0 types

# targets, logic, etc are within a set of macros shared by all schemas
include(${SC_CMAKE_DIR}/SC_CXX_schema_macros.cmake)
set(sdai_inverse_attr_file_count 16)

PROJECT(sdai_inverse_attr)
# list headers so they can be installed - entity, type, misc
set(sdai_inverse_attr_entity_hdrs
     entity/SdaiObject.h                                                         entity/SdaiReldefinesbytype.h                                               
     entity/SdaiWindow.h                                                            )

set(sdai_inverse_attr_type_hdrs
        )

set(sdai_inverse_attr_misc_hdrs
     Sdaiclasses.h   schema.h
     SdaiTEST_INVERSE_ATTRNames.h
     SdaiTEST_INVERSE_ATTR.h
   )

# install all headers
set(all_headers ${sdai_inverse_attr_entity_hdrs} ${sdai_inverse_attr_type_hdrs} ${sdai_inverse_attr_misc_hdrs})
foreach( header_file ${all_headers} )
  set(curr_dir)
  get_filename_component(curr_dir ${header_file} PATH)
  get_filename_component(curr_name ${header_file} NAME)
  if (curr_dir)
    install( FILES ${header_file} DESTINATION "include/schemas/sdai_inverse_attr/${curr_dir}" )
  else (curr_dir)
    install( FILES ${header_file} DESTINATION "include/schemas/sdai_inverse_attr" )
  endif (curr_dir)
endforeach()
# implementation files - 3 lists

# unity build: #include small .cc files to reduce the number
# of translation units that must be compiled
if(SC_UNITY_BUILD)
  # turns off include statements within type and entity .cc's - the unity T.U.'s include a unity header
  add_definitions( -DSC_SDAI_UNITY_BUILD)
  set(sdai_inverse_attr_entity_impls SdaiTEST_INVERSE_ATTR_unity_entities.cc)
  set(sdai_inverse_attr_type_impls SdaiTEST_INVERSE_ATTR_unity_types.cc)
else(SC_UNITY_BUILD)
  set(sdai_inverse_attr_entity_impls
     entity/SdaiObject.cc                                                        entity/SdaiReldefinesbytype.cc                                              
     entity/SdaiWindow.cc                                                           )

  set(sdai_inverse_attr_type_impls
        )
endif(SC_UNITY_BUILD)

set( sdai_inverse_attr_misc_impls
     SdaiAll.cc    compstructs.cc    schema.cc
     SdaiTEST_INVERSE_ATTR.cc
     SdaiTEST_INVERSE_ATTR.init.cc   )

set(schema_target_files ${sdai_inverse_attr_entity_impls} ${sdai_inverse_attr_type_impls} ${sdai_inverse_attr_misc_impls})
SCHEMA_TARGETS("/home/runner/work/stepcode/stepcode/test/unitary_schemas/inverse_attr.exp" "test_inverse_attr"
                 "${schema_target_files}")
