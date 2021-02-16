FROM ubuntu:20.04 AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

# Multi-stage build
FROM ubuntu:20.04

# Copy Apache2
COPY --from=builder /usr/lib/apache2 /usr/lib/apache2
COPY --from=builder /usr/share/apache2 /usr/share/apache2
COPY --from=builder /usr/lib/php /usr/lib/php
COPY --from=builder /var/lib/php /var/lib/php
COPY --from=builder /lib/lsb /lib/lsb
COPY --from=builder /var/lib/apache2 /var/lib/apache2
COPY --from=builder /var/www /var/www
COPY --from=builder /var/log/apache2 /var/log/apache2

# Copy Nagios4
COPY --from=builder /usr/share/nagios4 /usr/share/nagios4
COPY --from=builder /usr/share/nagios4-cgi /usr/share/nagios4-cgi
COPY --from=builder /var/lib/nagios4 /var/lib/nagios4
COPY --from=builder /var/log/nagios4 /var/log/nagios4
COPY --from=builder /usr/lib/cgi-bin/nagios4 /usr/lib/cgi-bin/nagios4
COPY --from=builder /usr/lib/nagios /usr/lib/nagios
COPY --from=builder /var/lib/nagios /var/lib/nagios

# Libraries need for Nagios4
COPY --from=builder /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/

# Copy system common 
COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
COPY --from=builder /etc /etc
COPY --from=builder /usr/sbin /usr/sbin

RUN chown -R nagios:nagios /var/lib/nagios && chown -R nagios:www-data /var/lib/nagios4

COPY start.sh /start.sh
CMD /start.sh
