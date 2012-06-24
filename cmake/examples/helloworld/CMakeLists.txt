cmake_minimum_required (VERSION 2.6) 
cmake_policy(SET CMP0008 NEW) # For Xcode

project (HelloWorld) 

set(CMAKE_SHARED_MODULE_SUFFIX ".bundle")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)


set(ENV{MAYA_LOCATION} /Applications/Autodesk/maya2012/Maya.app/Contents)
find_package(Maya)


# OpenMayaAnim, OpenMayaFX, OpenMayaRender,OpenMayaUI 
#SET( MAYA_EXTRA_LIBRARIES  "OpenMaya" )

add_library (helloCmd MODULE helloWorld.cpp)
target_link_libraries (helloCmd ${MAYA_LIBRARIES}) 

add_library (helix MODULE helix.cpp)
target_link_libraries (helix ${MAYA_LIBRARIES}) 