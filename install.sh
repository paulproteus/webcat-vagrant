#!/bin/bash

# Grab the Web-CAT war
wget 'http://colocrossing.dl.sourceforge.net/project/web-cat/Web-CAT%20Servlet/1.4.0/Web-CAT_1.4.0.war'
# Rename it
mv Web-CAT_1.4.0.war Web-CAT.war

# Set password for mysqlserver to password
echo 'mysql-server-5.5 mysql-server/root_password password password' | sudo debconf-set-selections
echo 'mysql-server-5.5 mysql-server/root_password_again password password' | sudo debconf-set-selections

# Need to update or else the installs won't work
sudo DEBIAN_FRONTEND=noninteractive apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tomcat7 mysql-server
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libxml-parser-perl
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential binutils-dev libiberty-dev

# Hack to get rid of lintl errors (modern ubuntu doesn't have or need lintl, let's fake it)
touch nothing.c
gcc -c -Wall -Werror -fpic nothing.c
gcc -shared -o libintl.so nothing.c
sudo mv libintl.so /usr/lib/x86_64-linux-gnu/libintl.so

# Set up the Web-CAT app
sudo service tomcat7 stop
sudo mv Web-CAT.war /var/lib/tomcat7/webapps/
sudo chown tomcat7 /var/lib/tomcat7/webapps/Web-CAT.war
sudo service tomcat7 start

# Get a storage path ready
STORAGE_PATH="/var/webcat"
sudo mkdir $STORAGE_PATH
sudo chown tomcat7 $STORAGE_PATH

# User needs to manually set up Web-CAT in the browser at this point
# Go to http://localhost:8080/Web-CAT
echo "Yay. The first part of the installation is done."
echo "Now go to http://localhost:8080/Web-CAT so Web-CAT can start loading."
echo "It will take a while."

# After manual setup, CppTddPlugin/build.xml, CppTddPlugin/obj/assert.c, and 
# CppTddPlugin/cxxtest/chkptr_table.cpp need to be modified for the CppTddPlugin
# to work
