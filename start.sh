#!/bin/bash

service nagios start
service apache2 start
tail -f /usr/local/nagios/var/nagios.log
