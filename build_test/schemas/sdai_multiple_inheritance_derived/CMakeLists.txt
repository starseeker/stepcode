# -----  GENERATED FILE  -----
# -----   Do not edit!   -----

# schema name: multiple_inheritance_derived
# (short name: sdai_multiple_inheritance_derived)
# 11 entities, 1 types

# targets, logic, etc are within a set of macros shared by all schemas
include(${SC_CMAKE_DIR}/SC_CXX_schema_macros.cmake)
set(sdai_multiple_inheritance_derived_file_count 34)

PROJECT(sdai_multiple_inheritance_derived)
# list headers so they can be installed - entity, type, misc
set(sdai_multiple_inheritance_derived_entity_hdrs
     entity/SdaiAa.h                                                             entity/SdaiAc.h                                                             
     entity/SdaiAb.h                                                             entity/SdaiAabb.h                                                           
     entity/SdaiA.h                                                              entity/SdaiB.h                                                              
     entity/SdaiC.h                                                              entity/SdaiD.h                                                              
     entity/SdaiDd.h                                                             entity/SdaiBb.h                                                             
     entity/SdaiBa.h                                                                )

set(sdai_multiple_inheritance_derived_type_hdrs
     type/SdaiB_name_var.h                                                          )

set(sdai_multiple_inheritance_derived_misc_hdrs
     Sdaiclasses.h   schema.h
     SdaiMULTIPLE_INHERITANCE_DERIVEDNames.h
     SdaiMULTIPLE_INHERITANCE_DERIVED.h
   )

# install all headers
set(all_headers ${sdai_multiple_inheritance_derived_entity_hdrs} ${sdai_multiple_inheritance_derived_type_hdrs} ${sdai_multiple_inheritance_derived_misc_hdrs})
foreach( header_file ${all_headers} )
  set(curr_dir)
  get_filename_component(curr_dir ${header_file} PATH)
  get_filename_component(curr_name ${header_file} NAME)
  if (curr_dir)
    install( FILES ${header_file} DESTINATION "include/schemas/sdai_multiple_inheritance_derived/${curr_dir}" )
  else (curr_dir)
    install( FILES ${header_file} DESTINATION "include/schemas/sdai_multiple_inheritance_derived" )
  endif (curr_dir)
endforeach()
# implementation files - 3 lists

# unity build: #include small .cc files to reduce the number
# of translation units that must be compiled
if(SC_UNITY_BUILD)
  # turns off include statements within type and entity .cc's - the unity T.U.'s include a unity header
  add_definitions( -DSC_SDAI_UNITY_BUILD)
  set(sdai_multiple_inheritance_derived_entity_impls SdaiMULTIPLE_INHERITANCE_DERIVED_unity_entities.cc)
  set(sdai_multiple_inheritance_derived_type_impls SdaiMULTIPLE_INHERITANCE_DERIVED_unity_types.cc)
else(SC_UNITY_BUILD)
  set(sdai_multiple_inheritance_derived_entity_impls
     entity/SdaiAa.cc                                                            entity/SdaiAc.cc                                                            
     entity/SdaiAb.cc                                                            entity/SdaiAabb.cc                                                          
     entity/SdaiA.cc                                                             entity/SdaiB.cc                                                             
     entity/SdaiC.cc                                                             entity/SdaiD.cc                                                             
     entity/SdaiDd.cc                                                            entity/SdaiBb.cc                                                            
     entity/SdaiBa.cc                                                               )

  set(sdai_multiple_inheritance_derived_type_impls
     type/SdaiB_name_var.cc                                                         )
endif(SC_UNITY_BUILD)

set( sdai_multiple_inheritance_derived_misc_impls
     SdaiAll.cc    compstructs.cc    schema.cc
     SdaiMULTIPLE_INHERITANCE_DERIVED.cc
     SdaiMULTIPLE_INHERITANCE_DERIVED.init.cc   )

set(schema_target_files ${sdai_multiple_inheritance_derived_entity_impls} ${sdai_multiple_inheritance_derived_type_impls} ${sdai_multiple_inheritance_derived_misc_impls})
SCHEMA_TARGETS("/home/runner/work/stepcode/stepcode/test/unitary_schemas/multiple_inheritance_derived.exp" "multiple_inheritance_derived"
                 "${schema_target_files}")
