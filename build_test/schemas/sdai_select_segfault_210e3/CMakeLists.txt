# -----  GENERATED FILE  -----
# -----   Do not edit!   -----

# schema name: select_segfault_210e3
# (short name: sdai_select_segfault_210e3)
# 45 entities, 6 types

# targets, logic, etc are within a set of macros shared by all schemas
include(${SC_CMAKE_DIR}/SC_CXX_schema_macros.cmake)
set(sdai_select_segfault_210e3_file_count 112)

PROJECT(sdai_select_segfault_210e3)
# list headers so they can be installed - entity, type, misc
set(sdai_select_segfault_210e3_entity_hdrs
     entity/SdaiBinary_numeric_expression.h                                      entity/SdaiDate_and_time.h                                                  
     entity/SdaiRepresentation.h                                                 entity/SdaiBoolean_literal.h                                                
     entity/SdaiRow_representation_item.h                                        entity/SdaiLiteral_number.h                                                 
     entity/SdaiDate_time_representation_item.h                                  entity/SdaiSlash_expression.h                                               
     entity/SdaiTable_representation_item.h                                      entity/SdaiLogical_representation_item.h                                    
     entity/SdaiMeasure_representation_item.h                                    entity/SdaiRational_representation_item.h                                   
     entity/SdaiValue_representation_item.h                                      entity/SdaiReal_representation_item.h                                       
     entity/SdaiRepresentation_context.h                                         entity/SdaiPoint_and_vector.h                                               
     entity/SdaiMapped_item.h                                                    entity/SdaiDerived_unit.h                                                   
     entity/SdaiCartesian_point.h                                                entity/SdaiPoint_path.h                                                     
     entity/SdaiInteger_representation_item.h                                    entity/SdaiPlane_angle_unit.h                                               
     entity/SdaiReal_literal.h                                                   entity/SdaiBinary_representation_item.h                                     
     entity/SdaiDate_representation_item.h                                       entity/SdaiBinary_generic_expression.h                                      
     entity/SdaiRepresentation_item.h                                            entity/SdaiMeasure_with_unit.h                                              
     entity/SdaiDate.h                                                           entity/SdaiConversion_based_unit.h                                          
     entity/SdaiDimensional_exponents.h                                          entity/SdaiNumeric_expression.h                                             
     entity/SdaiInt_literal.h                                                    entity/SdaiSi_unit.h                                                        
     entity/SdaiPlane_angle_measure_with_unit.h                                  entity/SdaiLogical_literal.h                                                
     entity/SdaiPoint.h                                                          entity/SdaiDirection.h                                                      
     entity/SdaiGeneric_expression.h                                             entity/SdaiRepresentation_map.h                                             
     entity/SdaiStyled_item.h                                                    entity/SdaiGeometric_representation_item.h                                  
     entity/SdaiBoolean_representation_item.h                                    entity/SdaiCompound_representation_item.h                                   
     entity/SdaiNamed_unit.h                                                        )

set(sdai_select_segfault_210e3_type_hdrs
     type/SdaiPoint_and_vector_member.h                                          type/SdaiSi_prefix_var.h                                                    
     type/SdaiMeasure_value.h                                                    type/SdaiSi_unit_name_var.h                                                 
     type/SdaiUnit.h                                                             type/SdaiCompound_item_definition.h                                         
        )

set(sdai_select_segfault_210e3_misc_hdrs
     Sdaiclasses.h   schema.h
     SdaiSELECT_SEGFAULT_210E3Names.h
     SdaiSELECT_SEGFAULT_210E3.h
   )

# install all headers
set(all_headers ${sdai_select_segfault_210e3_entity_hdrs} ${sdai_select_segfault_210e3_type_hdrs} ${sdai_select_segfault_210e3_misc_hdrs})
foreach( header_file ${all_headers} )
  set(curr_dir)
  get_filename_component(curr_dir ${header_file} PATH)
  get_filename_component(curr_name ${header_file} NAME)
  if (curr_dir)
    install( FILES ${header_file} DESTINATION "include/schemas/sdai_select_segfault_210e3/${curr_dir}" )
  else (curr_dir)
    install( FILES ${header_file} DESTINATION "include/schemas/sdai_select_segfault_210e3" )
  endif (curr_dir)
endforeach()
# implementation files - 3 lists

# unity build: #include small .cc files to reduce the number
# of translation units that must be compiled
if(SC_UNITY_BUILD)
  # turns off include statements within type and entity .cc's - the unity T.U.'s include a unity header
  add_definitions( -DSC_SDAI_UNITY_BUILD)
  set(sdai_select_segfault_210e3_entity_impls SdaiSELECT_SEGFAULT_210E3_unity_entities.cc)
  set(sdai_select_segfault_210e3_type_impls SdaiSELECT_SEGFAULT_210E3_unity_types.cc)
else(SC_UNITY_BUILD)
  set(sdai_select_segfault_210e3_entity_impls
     entity/SdaiBinary_numeric_expression.cc                                     entity/SdaiDate_and_time.cc                                                 
     entity/SdaiRepresentation.cc                                                entity/SdaiBoolean_literal.cc                                               
     entity/SdaiRow_representation_item.cc                                       entity/SdaiLiteral_number.cc                                                
     entity/SdaiDate_time_representation_item.cc                                 entity/SdaiSlash_expression.cc                                              
     entity/SdaiTable_representation_item.cc                                     entity/SdaiLogical_representation_item.cc                                   
     entity/SdaiMeasure_representation_item.cc                                   entity/SdaiRational_representation_item.cc                                  
     entity/SdaiValue_representation_item.cc                                     entity/SdaiReal_representation_item.cc                                      
     entity/SdaiRepresentation_context.cc                                        entity/SdaiPoint_and_vector.cc                                              
     entity/SdaiMapped_item.cc                                                   entity/SdaiDerived_unit.cc                                                  
     entity/SdaiCartesian_point.cc                                               entity/SdaiPoint_path.cc                                                    
     entity/SdaiInteger_representation_item.cc                                   entity/SdaiPlane_angle_unit.cc                                              
     entity/SdaiReal_literal.cc                                                  entity/SdaiBinary_representation_item.cc                                    
     entity/SdaiDate_representation_item.cc                                      entity/SdaiBinary_generic_expression.cc                                     
     entity/SdaiRepresentation_item.cc                                           entity/SdaiMeasure_with_unit.cc                                             
     entity/SdaiDate.cc                                                          entity/SdaiConversion_based_unit.cc                                         
     entity/SdaiDimensional_exponents.cc                                         entity/SdaiNumeric_expression.cc                                            
     entity/SdaiInt_literal.cc                                                   entity/SdaiSi_unit.cc                                                       
     entity/SdaiPlane_angle_measure_with_unit.cc                                 entity/SdaiLogical_literal.cc                                               
     entity/SdaiPoint.cc                                                         entity/SdaiDirection.cc                                                     
     entity/SdaiGeneric_expression.cc                                            entity/SdaiRepresentation_map.cc                                            
     entity/SdaiStyled_item.cc                                                   entity/SdaiGeometric_representation_item.cc                                 
     entity/SdaiBoolean_representation_item.cc                                   entity/SdaiCompound_representation_item.cc                                  
     entity/SdaiNamed_unit.cc                                                       )

  set(sdai_select_segfault_210e3_type_impls
     type/SdaiPoint_and_vector_member.cc                                         type/SdaiSi_prefix_var.cc                                                   
     type/SdaiMeasure_value.cc                                                   type/SdaiSi_unit_name_var.cc                                                
     type/SdaiUnit.cc                                                            type/SdaiCompound_item_definition.cc                                        
        )
endif(SC_UNITY_BUILD)

set( sdai_select_segfault_210e3_misc_impls
     SdaiAll.cc    compstructs.cc    schema.cc
     SdaiSELECT_SEGFAULT_210E3.cc
     SdaiSELECT_SEGFAULT_210E3.init.cc   )

set(schema_target_files ${sdai_select_segfault_210e3_entity_impls} ${sdai_select_segfault_210e3_type_impls} ${sdai_select_segfault_210e3_misc_impls})
SCHEMA_TARGETS("/home/runner/work/stepcode/stepcode/test/misc/select_segfault_210e3.exp" "select_segfault_210e3"
                 "${schema_target_files}")
