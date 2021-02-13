#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

APACHE="2.4.46"
NAGIOS="4.4.6"


pacman --noconfirm -Syyu
pacman --noconfirm -S gcc glibc make wget unzip apache php gd traceroute php-apache

# Download and compile Nagios-core from the official repo.
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-$NAGIOS.tar.gz
tar -xvf nagios-$NAGIOS.tar.gz
cd /tmp/nagios-$NAGIOS
mkdir /etc/apache2/sites-enabled
./configure --with-httpd-conf=/etc/httpd/conf/extra
make all

# This creates the nagios user and group. The www-data user is also added to the nagios group.
make install-groups-users
usermod -a -G nagios http

# This step installs the binary files, CGIs, and HTML files.
make install

# This installs the service or daemon files and also configures them to start on boot.
# make install-daemoninit

# This installs and configures the external command file.
make install-commandmode

# This installs the *SAMPLE* configuration files. These are required as Nagios needs some configuration files to allow it to start.
make install-config

# This installs the Apache web server configuration files and configures the Apache settings.
make install-webconf
#a2enmod rewrite
#a2enmod cgi

sed -i 's/^#LoadModule mpm_prefork_module modules\/mod_mpm_prefork\.so/LoadModule mpm_prefork_module modules\/mod_mpm_prefork\.so/g' /etc/httpd/conf/httpd.conf
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php index.html index.htm AddType application\/x-httpd-php .phpAddType application\/x-httpd-php-source .phps/g' /etc/httpd/conf/httpd.conf
sed -i 's/#LoadModule cgid_module/LoadModule cgid_module/g' /etc/httpd/conf/httpd.conf
sed -i 's/#LoadModule cgi_module/LoadModule cgi_module/g' /etc/httpd/conf/httpd.conf
echo 'LoadModule php7_module modules/libphp7.so' >> /etc/httpd/conf/httpd.conf
echo 'Include "conf/extra/nagios.conf"' >> /etc/httpd/conf/httpd.conf
echo 'Include "conf/extra/php7_module.conf"' >> /etc/httpd/conf/httpd.conf
printf '\n<FilesMatch ".php$">\n' >> /etc/httpd/conf/httpd.conf
printf '\tSetHandler application/x-httpd-php\n' >> /etc/httpd/conf/httpd.conf
printf '</FilesMatch>\n' >> /etc/httpd/conf/httpd.conf
printf '<FilesMatch ".phps$">\n' >> /etc/httpd/conf/httpd.conf
printf '\tSetHandler application/x-httpd-php-source\n' >> /etc/httpd/conf/httpd.conf
printf '</FilesMatch>\n' >> /etc/httpd/conf/httpd.conf
