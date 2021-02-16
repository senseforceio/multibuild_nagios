#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

PLUGINS="2.3.3"
NRPE="4.0.2"

# Download Nagios plugins
cd /tmp
wget http://www.nagios-plugins.org/download/nagios-plugins-$PLUGINS.tar.gz
tar -xvf nagios-plugins-$PLUGINS.tar.gz
cd ./nagios-plugins-$PLUGINS
./configure
make
make install

# Download NRPE plugin
cd /tmp
wget https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-$NRPE/nrpe-$NRPE.tar.gz
tar -xvf nrpe-$NRPE.tar.gz
cd ./nrpe-$NRPE
./configure --enable-command-args --with-ssl-lib=/usr/lib/x86_64-linux-gnu/ --with-init-type=sysv # sysv if there is /etc/init.d (Debian/Ubuntu official containers)
make install-groups-users
make all
make install
make install-init

# Delete cached files we don't need anymore:
apt-get clean
rm -rf /var/lib/apt/lists/*
