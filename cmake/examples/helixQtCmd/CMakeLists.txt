cmake_minimum_required (VERSION 2.6) 
project (helixQtCmd) 

# QTDIR can be set to indicate to help finding Qt
# set(ENV{QTDIR} /usr/local/Cellar/qt/4.7.1/)

set(CMAKE_SHARED_MODULE_SUFFIX ".bundle")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)


set(ENV{MAYA_LOCATION} /Applications/Autodesk/maya2012/Maya.app/Contents)
find_package(Maya)
FIND_PACKAGE(Qt4 REQUIRED)

# OpenMayaAnim, OpenMayaFX, OpenMayaRender,OpenMayaUI 
#SET( MAYA_EXTRA_LIBRARIES  "OpenMaya" )

SET(helixQtCmd_SOURCES helixQtCmd.cpp)
SET(helixQtCmd_HEADERS helixQtCmd.h)

## Qt
QT4_WRAP_CPP(helixQtCmd_HEADERS_MOC ${helixQtCmd_HEADERS})
INCLUDE(${QT_USE_FILE})
ADD_DEFINITIONS(${QT_DEFINITIONS})

add_library(helixQtCmd MODULE ${helixQtCmd_SOURCES} ${helixQtCmd_HEADERS_MOC})
target_link_libraries(helixQtCmd ${QT_LIBRARIES} ${MAYA_LIBRARIES})
