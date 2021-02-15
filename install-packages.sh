#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

# Update the package listing, so we know what package exist:
apt-get update

# Install security updates:
apt-get -y upgrade

# Install new packages for nagios install
apt-get install -y wget apt-transport-https ca-certificates gnupg2

echo "deb https://repo.nagios.com/deb/focal /" > /etc/apt/sources.list.d/nagios.list

# Add our public GPG key
wget -qO - https://repo.nagios.com/GPG-KEY-NAGIOS-V2 | apt-key add -

# Update your repositories
apt-get update

# Install Nagios4
apt-get install -y --no-install-recommends nagios4 apache2
a2enmod auth_digest
a2enmod authz_groupfile

# Delete files we don't need:
apt-get clean
rm -rf /var/lib/apt/lists/*
find / -type d | grep -v nagios | grep doc | xargs rm -rf
