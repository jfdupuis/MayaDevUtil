# - Maya finder module
# This module searches for a valid Maya instalation. 
# It searches for Maya's devkit, libraries, executables
# and related paths (scripts)
#
# Variables that will be defined: 
# MAYA_FOUND          Defined if a Maya installation has been detected
# MAYA_EXECUTABLE     Path to Maya's executable
# MAYA_<lib>_FOUND    Defined if <lib> has been found
# MAYA_<lib>_LIBRARY  Path to <lib> library
# MAYA_INCLUDE_DIRS   Path to the devkit's include directories

# Forked from Francisco Requena's https://github.com/frarees/maya-cmake

#=============================================================================
# Copyright 2011-2012 Jean-Francois Dupuis <jeanfrancois.dupuis@gmail.com>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

#SET(MAYA_VERSION_2012 TRUE)

## add one to this list to match your install if none match

IF(APPLE)
	FIND_PATH(MAYA_DEVKIT_DIR include/maya/MFn.h 
		PATHS
			ENV MAYA_LOCATION
		PATH_SUFFIXES
			../../devkit
	)
	
	FIND_PATH(MAYA_LIBRARY_DIR libOpenMaya.dylib
		PATHS
			ENV MAYA_LOCATION
		PATH_SUFFIXES
			MacOS/
		DOC "Maya's libraries path"
	)
	
	add_definitions(-D_BOOL -DOSMac_ -DREQUIRE_IOSTREAM)

ENDIF(APPLE)



# Untested
IF(UNIX)
	FIND_PATH(MAYA_DEVKIT_DIR include/maya/MFn.h 
		PATH
			ENV MAYA_LOCATION
			"/usr/autodesk/maya2012.17-x64"
			"/usr/autodesk/maya2012-x64"
			"/usr/autodesk/maya2011-x64"
			"/usr/autodesk/maya2010-x64"
	)
	FIND_PATH(MAYA_LIBRARY_DIR libOpenMaya.so
		PATHS
			ENV MAYA_LOCATION
			${MAYA_DEVKIT_DIR}
		PATH_SUFFIXES
			lib/
		DOC "Maya's libraries path"
	)
ENDIF(UNIX)
 
#Untested
IF(WIN32)
	FIND_PATH(MAYA_DEVKIT_DIR include/maya/MFn.h 
		PATH
			ENV MAYA_LOCATION
			"C:/Program Files/Autodesk/Maya2012-x64"
			"C:/Program Files/Autodesk/Maya2012"
			"C:/Program Files (x86)/Autodesk/Maya2012"
			"C:/Autodesk/maya-2012x64"
			"C:/Program Files/Autodesk/Maya2011-x64"
			"C:/Program Files/Autodesk/Maya2011"
			"C:/Program Files (x86)/Autodesk/Maya2011"
			"C:/Autodesk/maya-2011x64"
			"C:/Program Files/Autodesk/Maya2010-x64"
			"C:/Program Files/Autodesk/Maya2010"
			"C:/Program Files (x86)/Autodesk/Maya2010"
			"C:/Autodesk/maya-2010x64"
	)
	FIND_PATH(MAYA_LIBRARY_DIR OpenMaya.lib
		PATHS
			ENV MAYA_LOCATION
			${MAYA_DEVKIT_DIR}
		PATH_SUFFIXES
			lib/
		DOC "Maya's libraries path"
	)
ENDIF(WIN32)

FIND_PATH(MAYA_INCLUDE_DIR maya/MFn.h
	PATHS
		ENV MAYA_LOCATION
		${MAYA_DEVKIT_DIR}
	PATH_SUFFIXES
		../../devkit/include/
		include/
	DOC "Maya's devkit headers path"
)


LIST(APPEND MAYA_INCLUDE_DIRS ${MAYA_INCLUDE_DIR})

FIND_PATH(MAYA_DEVKIT_PLUGIN_INC_DIR GL/glext.h
	PATHS
		${MAYA_DEVKIT_DIR}
	PATH_SUFFIXES
		plug-ins/
	DOC "Maya's devkit headers path"
)
LIST(APPEND MAYA_INCLUDE_DIRS ${MAYA_DEVKIT_PLUGIN_INC_DIR})

# Find the basic libraries
FOREACH(MAYA_LIB
		  DataModel 
		  OpenMaya 
		  AnimSlice 
		  DeformSlice 
		  Modifiers 
		  DynSlice 
		  KinSlice 
		  ModelSlice 
		  NurbsSlice 
		  PolySlice 
		  ProjectSlice 
		  Image 
		  Translators 
		  RenderModel 
		  NurbsEngine 
		  DependEngine 
		  CommandEngine 
		  Foundation 
		  IMFbase 
		)
  
	FIND_LIBRARY(MAYA_${MAYA_LIB}_LIBRARY ${MAYA_LIB}
		PATHS
			${MAYA_LIBRARY_DIR}
		NO_SYSTEM_ENVIRONMENT_PATH
		NO_DEFAULT_PATH
		DOC "Maya's ${MAYA_LIB} library path"
	)
	
	LIST( APPEND MAYA_LIBRARIES ${MAYA_${MAYA_LIB}_LIBRARY} )

ENDFOREACH(MAYA_LIB)


# Find the extra libraries
FOREACH(MAYA_LIB
 		OpenMayaAnim
 		OpenMayaFX
 		OpenMayaRender
 		OpenMayaUI  
		)
  
	FIND_LIBRARY(MAYA_${MAYA_LIB}_LIBRARY ${MAYA_LIB}
		PATHS
			${MAYA_LIBRARY_DIR}
		NO_SYSTEM_ENVIRONMENT_PATH
		NO_DEFAULT_PATH
		DOC "Maya's ${MAYA_LIB} library path"
	)

ENDFOREACH(MAYA_LIB)


FIND_PROGRAM(MAYA_EXECUTABLE maya
	HINTS
		"$ENV{MAYA_LOCATION}/bin"
	DOC "Maya's executable"
)

FIND_PROGRAM(MAYA_LINKER mayald
	HINTS
		"${MAYA_DEVKIT_DIR}/bin"
	DOC "Maya's linker"
)

include_directories(${MAYA_INCLUDE_DIRS}) 

set(MAYABIN ${MAYA_EXECUTABLE})
set(MAYA_ARCHES $(shell lipo -info ${MAYABIN} | sed 's/^.*://') )


set(DYNLIB_LOCATION $ENV{MAYA_LOCATION}/MacOS)
set(FRAMEWORK_LOCATION $ENV{MAYA_LOCATION}/Frameworks)
set(OTHERFLAGS "-F${FRAMEWORK_LOCATION} -mmacosx-version-min=10.6 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk -headerpad_max_install_names -dynamic")
set(LREMAP "-Wl,-executable_path,${DYNLIB_LOCATION}")
set(CMAKE_MODULE_LINKER_FLAGS "-fno-gnu-keywords -fpascal-strings -O3 ${ARCH_FLAGS} ${LREMAP} ${OTHERFLAGS}")


# handle the QUIETLY and REQUIRED arguments and set MAYA_FOUND to TRUE if all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Maya DEFAULT_MSG MAYA_LIBRARIES MAYA_EXECUTABLE MAYA_INCLUDE_DIRS)

if(NOT MAYA_FOUND AND NOT MAYA_FIND_QUIETLY)
	message("Maya not found with location: $ENV{MAYA_LOCATION}")
endif()