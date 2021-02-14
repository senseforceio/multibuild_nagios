#!/bin/bash

service nagios start
service apache2 start
multitail -s 2 /usr/local/nagios/var/nagios.log /var/log/apache2/error.log
