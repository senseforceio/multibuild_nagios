#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

# Tell apt-get we're never going to be able to give manual
# feedback:
export DEBIAN_FRONTEND=noninteractive

# Install Apache from repo
apt-get update
apt-get -y upgrade 
apt-get install -y apache2 apache2-utils php gawk
apt-get clean
rm -rf /var/lib/apt/lists/*
