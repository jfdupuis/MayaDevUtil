// Example Plugin: helloCmd.cpp
//
// This plugin uses DeclareSimpleCommand macro
// to do the necessary initialization for a simple command
// plugin with one argument.
//
// Once this plugin is loaded by the Plugin Manager,
// it can be run from the Maya command line (i.e. script
// editor) giving it just one parameter like this:
//
//    hello Maya
//
// which will simply print the following message
// in the Output Window:
//
//    Hello Maya
//
// $RCSfile: helloCmd.cpp $     $Revision: /main/13 $

#include <maya/MIOStream.h>
#include <maya/MSimple.h>


// Use a Maya macro to setup a simple hello class
// with methods for initialization, etc.
//
DeclareSimpleCommand( hello, PLUGIN_COMPANY, "4.5");

// All we need to do is supply the doIt method
// which in this case only prints "Hello" followed
// by the first argument given in the command line.
//
MStatus hello::doIt( const MArgList& args )
{

	cout<<"Hello "<<args.asString(0).asChar()<<endl;
	return MS::kSuccess;
}

MStatus hello::initializePlugin (MObject obj)
{
	MStatus status;
	MFnPlugin plugin (obj, PLUGIN_COMPANY, "4.5");
	status = plugin.registerFileTranslator ("Hello", "", TanimExportUtil::creator);
	return (status);
}

MStatus hello::uninitializePlugin (MObject obj)
{
	MFnPlugin plugin (obj);
	plugin.deregisterFileTranslator ("Hello");
	return (MS::kSuccess);
}