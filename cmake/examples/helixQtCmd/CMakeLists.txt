cmake_minimum_required (VERSION 2.6) 
cmake_policy(SET CMP0008 NEW) # For Xcode

############################################################################
# Define the project and plugin name and source [REQUIRED]
############################################################################

project(helixQtCmd) 

set(PLUGIN_NAME helixQtCmd)

set(${PLUGIN_NAME}_SOURCES helixQtCmd.cpp)
set(${PLUGIN_NAME}_HEADERS helixQtCmd.h)

############################################################################
# Define Maya and Qt location [REQUIRED]
############################################################################

# QTDIR can be set to indicate to help finding Qt
set(ENV{QTDIR} /usr/local/Cellar/qt/4.7.1/)

# Set the maya location
set(ENV{MAYA_LOCATION} /Applications/Autodesk/maya2013/Maya.app/Contents)

############################################################################
# Find the libraries
############################################################################
set(CMAKE_SHARED_MODULE_SUFFIX ".bundle")
set(CMAKE_SHARED_MODULE_PREFIX "")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Find Maya 
find_package(Maya)
# Find Qt
find_package(Qt4 REQUIRED)

# call moc
QT4_WRAP_CPP(${PLUGIN_NAME}_HEADERS_MOC ${${PLUGIN_NAME}_HEADERS})

include(${QT_USE_FILE})
add_definitions(${QT_DEFINITIONS})

############################################################################
# Define the required additional libraries [REQUIRED]
############################################################################

# Add the desired maya libraries
#OpenMayaAnim, OpenMayaFX, OpenMayaRender,OpenMayaUI 
#set( MAYA_EXTRA_LIBRARIES  "OpenMayaAnim" )

#Overwrite the Qt linking libraries to link to the one provided by maya
set(QT_LIBRARIES $ENV{MAYA_LOCATION}/MacOS/QtGui $ENV{MAYA_LOCATION}/MacOS/QtCore)

############################################################################
# Link plugin module
############################################################################
add_library(${PLUGIN_NAME} MODULE ${${PLUGIN_NAME}_SOURCES} ${${PLUGIN_NAME}_HEADERS_MOC})
target_link_libraries(${PLUGIN_NAME} ${QT_LIBRARIES} ${MAYA_LIBRARIES})
