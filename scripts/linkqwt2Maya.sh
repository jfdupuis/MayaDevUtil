#!/bin/bash

#Qwt
install_name_tool -id @executable_path/qwt qwt

install_name_tool -change QtGui.framework/Versions/4/QtGui @executable_path/QtGui qwt
install_name_tool -change QtCore.framework/Versions/4/QtCore @executable_path/QtCore qwt
install_name_tool -change QtSvg.framework/Versions/4/QtSvg @executable_path/QtSvg qwt