#ifndef  SDAICLASSES_H
#define  SDAICLASSES_H
// This file was generated by fedex_plus.  You probably don't want to edit
// it since your modifications will be lost if fedex_plus is used to
// regenerate it.
/* $Id$  */ 
#include <schema.h>

// Schema:  SdaiHEADER_SECTION_SCHEMA
extern Schema *  s_header_section_schema;

// Types:
typedef SCLP23(String) 	SdaiTime_stamp_text;
extern TypeDescriptor 	*header_section_schemat_time_stamp_text;
typedef SCLP23(String) 	SdaiSection_name;
extern TypeDescriptor 	*header_section_schemat_section_name;
typedef SCLP23(String) 	SdaiContext_name;
extern TypeDescriptor 	*header_section_schemat_context_name;
typedef SCLP23(String) 	SdaiSchema_name;
extern TypeDescriptor 	*header_section_schemat_schema_name;
typedef SCLP23(String) 	SdaiLanguage_name;
extern TypeDescriptor 	*header_section_schemat_language_name;
typedef SCLP23(String) 	SdaiExchange_structure_identifier;
extern TypeDescriptor 	*header_section_schemat_exchange_structure_identifier;

// Entities:
class SdaiSection_language;
typedef SdaiSection_language *  	SdaiSection_languageH;
typedef SdaiSection_language *  	SdaiSection_language_ptr;
typedef SdaiSection_language_ptr	SdaiSection_language_var;
#define SdaiSection_language__set 	SCLP23(DAObject__set)
#define SdaiSection_language__set_var 	SCLP23(DAObject__set_var)
extern EntityDescriptor 	*header_section_schemae_section_language;

class SdaiFile_population;
typedef SdaiFile_population *  	SdaiFile_populationH;
typedef SdaiFile_population *  	SdaiFile_population_ptr;
typedef SdaiFile_population_ptr	SdaiFile_population_var;
#define SdaiFile_population__set 	SCLP23(DAObject__set)
#define SdaiFile_population__set_var 	SCLP23(DAObject__set_var)
extern EntityDescriptor 	*header_section_schemae_file_population;

class SdaiFile_name;
typedef SdaiFile_name *  	SdaiFile_nameH;
typedef SdaiFile_name *  	SdaiFile_name_ptr;
typedef SdaiFile_name_ptr	SdaiFile_name_var;
#define SdaiFile_name__set 	SCLP23(DAObject__set)
#define SdaiFile_name__set_var 	SCLP23(DAObject__set_var)
extern EntityDescriptor 	*header_section_schemae_file_name;

class SdaiSection_context;
typedef SdaiSection_context *  	SdaiSection_contextH;
typedef SdaiSection_context *  	SdaiSection_context_ptr;
typedef SdaiSection_context_ptr	SdaiSection_context_var;
#define SdaiSection_context__set 	SCLP23(DAObject__set)
#define SdaiSection_context__set_var 	SCLP23(DAObject__set_var)
extern EntityDescriptor 	*header_section_schemae_section_context;

class SdaiFile_description;
typedef SdaiFile_description *  	SdaiFile_descriptionH;
typedef SdaiFile_description *  	SdaiFile_description_ptr;
typedef SdaiFile_description_ptr	SdaiFile_description_var;
#define SdaiFile_description__set 	SCLP23(DAObject__set)
#define SdaiFile_description__set_var 	SCLP23(DAObject__set_var)
extern EntityDescriptor 	*header_section_schemae_file_description;

class SdaiFile_schema;
typedef SdaiFile_schema *  	SdaiFile_schemaH;
typedef SdaiFile_schema *  	SdaiFile_schema_ptr;
typedef SdaiFile_schema_ptr	SdaiFile_schema_var;
#define SdaiFile_schema__set 	SCLP23(DAObject__set)
#define SdaiFile_schema__set_var 	SCLP23(DAObject__set_var)
extern EntityDescriptor 	*header_section_schemae_file_schema;

#endif
