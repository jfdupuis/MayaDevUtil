#include <math.h>
#include <maya/MIOStream.h>
#include <maya/MSimple.h>
#include <maya/MPoint.h>
#include <maya/MPointArray.h>
#include <maya/MDoubleArray.h>
#include <maya/MFnNurbsCurve.h>
DeclareSimpleCommand( doHelix, "Autodesk - Example", "2012");
MStatus doHelix::doIt( const MArgList& )
{
    MStatus stat;
    const unsigned deg = 3; // Curve Degree
    const unsigned ncvs = 20; // Number of CVs
    const unsigned spans = ncvs - deg; // Number of spans
    const unsigned nknots = spans+2*deg-1; // Number of knots
    double radius = 4.0; // Helix radius
    double pitch = 0.5; // Helix pitch
    unsigned i;
    MPointArray controlVertices;
    MDoubleArray knotSequences;
    // Set up cvs and knots for the helix
    //
    for (i = 0; i < ncvs; i++)
        controlVertices.append( MPoint( radius * cos( (double)i ),
									   pitch * (double)i, radius * sin( (double)i ) ) );
    for (i = 0; i < nknots; i++)
        knotSequences.append( (double)i );
    // Now create the curve
    //
    MFnNurbsCurve curveFn;
    MObject curve = curveFn.create( controlVertices,
								   knotSequences, deg, MFnNurbsCurve::kOpen, false, false, MObject::kNullObj, &stat );
    if ( MS::kSuccess != stat )
        cout << "Error creating curve.\n";
    return stat;
}