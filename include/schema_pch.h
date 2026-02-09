/* Precompiled header for STEPcode schema compilation
 * 
 * This header includes the most commonly used headers in schema-generated
 * C++ code to improve compilation times via CMake's precompiled header support.
 * 
 * This file is Copyright (c) 2024 United States Government as
 * represented by the U.S. Army Research Laboratory.
 * Licensed under the same terms as STEPcode (3-clause BSD).
 */

#ifndef SCHEMA_PCH_H
#define SCHEMA_PCH_H

/* Standard library headers commonly used in generated code */
#include <string>
#include <ctype.h>

/* Core STEP headers - these are included in every generated schema file */
#include "clstepcore/sdai.h"
#include "clstepcore/Registry.h"
#include "clstepcore/STEPaggregate.h"
#include "clstepcore/STEPundefined.h"
#include "clstepcore/ExpDict.h"
#include "clstepcore/STEPattribute.h"

/* Additional commonly used headers */
#include "clstepcore/STEPattributeList.h"
#include "clstepcore/STEPinvAttrList.h"
#include "clstepcore/complexSupport.h"

/* Utility headers */
#include "clutils/Str.h"
#include "clutils/errordesc.h"

#endif /* SCHEMA_PCH_H */
