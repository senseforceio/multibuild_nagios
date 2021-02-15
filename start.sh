#!/bin/bash

service nagios4 start
service apache2 start
tail -f /var/log/apache2/error.log /var/log/nagios4/nagios.log
