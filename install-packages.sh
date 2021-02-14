#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

NAGIOS_VERSION="4.4.6"
LIGHTTPD_VERSION="1.4.59"

# Update the package listing, so we know what package exist:
apt-get update

# Install security updates:
apt-get -y upgrade

# Install a new package, without unnecessary recommended packages:
apt-get -y install --no-install-recommends vim-tiny procps autoconf gcc libc6 make wget ca-certificates unzip php libgd-dev libpcre3-dev

# Delete cached files we don't need anymore:
apt-get clean
rm -rf /var/lib/apt/lists/*

# Download and compile Lighttpd from the officical repo.
cd /tmp
wget https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$LIGHTTPD_VERSION.tar.gz
tar -xvf lighttpd-$LIGHTTPD_VERSION.tar.gz
cd /tmp/lighttpd-$LIGHTTPD_VERSION
./configure --prefix="/usr/local/lighttpd"
make all
make install


# Download and compile Nagios-core from the official repo.
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-$NAGIOS_VERSION.tar.gz
tar -xvf nagios-$NAGIOS_VERSION.tar.gz
cd /tmp/nagios-$NAGIOS_VERSION
./configure --prefix="/usr/local/nagios"
make all

# This creates the nagios user and group. The www-data user is also added to the nagios group.
make install-groups-users
#usermod -a -G nagios www-data

# This step installs the binary files, CGIs, and HTML files.
make install

# This installs the service or daemon files and also configures them to start on boot.
# make install-init

# This installs and configures the external command file.
make install-commandmode

# This installs the *SAMPLE* configuration files. These are required as Nagios needs some configuration files to allow it to start.
make install-config
