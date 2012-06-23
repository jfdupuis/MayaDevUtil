#!/bin/bash

# Modify the Qwt library properties to ensure correct linking
# with the Qt libraries provided with maya

# Usage: execute the script in the folder where a copy of the
# qwt library is located. Then, move the modified library
# to the Maya.app/Content/MacOS folder.

#Qwt
install_name_tool -id @executable_path/qwt qwt

install_name_tool -change QtGui.framework/Versions/4/QtGui @executable_path/QtGui qwt
install_name_tool -change QtCore.framework/Versions/4/QtCore @executable_path/QtCore qwt
install_name_tool -change QtSvg.framework/Versions/4/QtSvg @executable_path/QtSvg qwt