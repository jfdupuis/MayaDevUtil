include(qtconfig)

TARGET 		= myplugin

CONFIG += qt debug

MOC_DIR = tmp
OBJECTS_DIR = tmp

# Input
HEADERS += $$files(src/*.h)
SOURCES += $$files(src/*.cpp)

INCLUDEPATH += src

ICON = ../icons/myplugin_logo.icns #OSX
#RC_FILE = ../icons/densitoplot_logo.icns #Windows icon
