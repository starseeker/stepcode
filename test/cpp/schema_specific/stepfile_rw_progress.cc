
#include "cleditor/STEPfile.h"
#include "clstepcore/sdai.h"
#include "clstepcore/STEPattribute.h"
#include "clstepcore/ExpDict.h"
#include "clstepcore/Registry.h"
#include "clutils/errordesc.h"
#include <algorithm>
#include <chrono>
#include <string>
#include <thread>

#ifdef HAVE_UNISTD_H
# include <unistd.h>
#endif

#include "SdaiAUTOMOTIVE_DESIGN.h"

#define DELAY(t) std::this_thread::sleep_for(std::chrono::milliseconds(t))

// NOTE this test requires std::thread (C++11, always available in this project).

void readProgressParallel( STEPfile & f, float & maxProgress ) {
    while( 1 ) {
        float p = f.GetReadProgress();
        if( p > maxProgress ) {
            maxProgress = p;
        }
        DELAY( 5 );
    }
}

void writeProgressParallel( STEPfile & f, float & maxProgress ) {
    while( 1 ) {
        float p = f.GetWriteProgress();
        if( p > maxProgress ) {
            maxProgress = p;
        }
        DELAY( 5 );
    }
}

int main( int argc, char * argv[] ) {
    float progress = 0.0;

    if( argc != 2 ) {
        cerr << "Wrong number of args. Use: " << argv[0] << " file.stp" << endl;
        exit( EXIT_FAILURE );
    }

    Registry  registry( SchemaInit );
    InstMgr   instance_list;
    STEPfile  sfile( registry, instance_list, "", false );

    // read the file
    std::thread r( readProgressParallel, std::ref( sfile ), std::ref( progress ) );
    sfile.ReadExchangeFile( argv[1] );
    r.detach();
    Severity readSev = sfile.Error().severity();
    if( readSev != SEVERITY_NULL ) {
        sfile.Error().PrintContents( cout );
        exit( EXIT_FAILURE );
    }
    if( progress < 55 ) { //55 is arbitrary. should be >50 due to how GetReadProgress() works.
        cerr << "Error: Read progress (" << progress << ") never exceeded the threshold (55). Exiting." << endl;
        exit( EXIT_FAILURE );
    } else {
        cout << "Read progress reached " << progress << "% - success." << endl;
    }
    progress = 0;

    // write the file
    std::thread w( writeProgressParallel, std::ref( sfile ), std::ref( progress ) );
    sfile.WriteExchangeFile( "out.stp" );
    w.detach();
    readSev = sfile.Error().severity();
    if( readSev != SEVERITY_NULL ) {
        sfile.Error().PrintContents( cout );
        exit( EXIT_FAILURE );
    }
    if( progress < 55 ) {
        cerr << "Error: Write progress (" << progress << ") never exceeded the threshold (55). Exiting." << endl;
        exit( EXIT_FAILURE );
    } else {
        cout << "Write progress reached " << progress << "% - success." << endl;
    }

    exit( EXIT_SUCCESS );
}


