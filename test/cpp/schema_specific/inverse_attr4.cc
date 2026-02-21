/** \file inverse_attr4.cc
 * Test that STEPfile::PopulateInverseAttributes() correctly fills in inverse
 * attribute maps after loading, using the same p21 test file as inverse_attr3.
 *
 * Previously, inverse attribute auto-population was only supported via
 * lazyInstMgr; this test verifies the equivalent functionality for STEPfile.
 */
#include "config.h"
#include "cleditor/STEPfile.h"
#include "clstepcore/sdai.h"
#include "clstepcore/STEPattribute.h"
#include "clstepcore/ExpDict.h"
#include "clstepcore/Registry.h"
#include "clutils/errordesc.h"
#include <algorithm>
#include <string>
#ifdef HAVE_UNISTD_H
# include <unistd.h>
#endif
#include "schema.h"

int main( int argc, char * argv[] ) {
    if( argc != 2 ) {
        cerr << "Wrong number of args!" << endl;
        exit( EXIT_FAILURE );
    }

    Registry  registry( SchemaInit );
    InstMgr   instance_list;
    STEPfile  sfile( registry, instance_list, "", false );

    sfile.ReadExchangeFile( argv[1] );
    if( sfile.Error().severity() <= SEVERITY_INCOMPLETE ) {
        sfile.Error().PrintContents( cout );
        exit( EXIT_FAILURE );
    }

    // Find the window instance
    SdaiWindow * instance = dynamic_cast< SdaiWindow * >(
        instance_list.GetApplication_instance( "window", 0 ) );
    if( !instance ) {
        cout << "No window instance found!" << endl;
        exit( EXIT_FAILURE );
    }
    cout << "instance #" << instance->StepFileId() << endl;

    // Verify iAMap was populated via PopulateInverseAttributes()
    SDAI_Application_instance::iAMap_t::value_type v = instance->getInvAttr( "isdefinedby" );
    iAstruct attr = v.second;
    if( attr.a && attr.a->EntryCount() ) {
        cout << "Map: found " << attr.a->EntryCount() << " inverse references." << endl;
    } else {
        cout << "Map: found no inverse references." << endl;
        exit( EXIT_FAILURE );
    }

    // Verify the generated accessor returns the same EntityAggregate
    EntityAggregate * aggr = instance->isdefinedby_();
    if( attr.a != aggr ) {
        cout << "Error! Map and accessor returned different EntityAggregate pointers." << endl;
        exit( EXIT_FAILURE );
    }
    if( aggr && aggr->EntryCount() ) {
        cout << "Found " << aggr->EntryCount() << " inverse references via accessor." << endl;
    } else {
        cout << "Accessor returned empty or null aggregate." << endl;
        exit( EXIT_FAILURE );
    }

    exit( EXIT_SUCCESS );
}
