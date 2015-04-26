#!/bin/bash

#These are settings chosen in the manual setup
STORAGE_PATH="/var/webcat"
SCHOOL_SHORT_NAME="LHU"
ADMIN_USERNAME="admin"

CHKPTR_TABLE_PATH=$STORAGE_PATH/UserScripts/$SCHOOL_SHORT_NAME/$ADMIN_USERNAME/CppTddPlugin/cxxtest/chkptr_table.cpp
BUILD_XML_PATH=$STORAGE_PATH/UserScripts/$SCHOOL_SHORT_NAME/$ADMIN_USERNAME/CppTddPlugin/build.xml
ASSERT_C_PATH=$STORAGE_PATH/UserScripts/$SCHOOL_SHORT_NAME/$ADMIN_USERNAME/CppTddPlugin/obj/assert.c

# change chkptr_table.cpp
sudo mv chkptr_table.cpp $CHKPTR_TABLE_PATH
sudo chown tomcat7 $CHKPTR_TABLE_PATH

# change CppTddPlugin/build.xml
sudo mv build.xml $BUILD_XML_PATH
sudo chown tomcat7 $BUILD_XML_PATH

# change CppTddPlugin/obj/assert.c
sudo mv assert.c $ASSERT_C_PATH
sudo chown tomcat7 $ASSERT_C_PATH
