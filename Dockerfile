FROM debian:stable-slim AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

## Multi-stage build
#FROM debian:stable-slim
#
## Copy Apache2
#COPY --from=builder /usr/lib/apache2 /usr/lib/apache2
#COPY --from=builder /usr/share/apache2 /usr/share/apache2
#COPY --from=builder /usr/lib/php /usr/lib/php
#COPY --from=builder /var/lib/php /var/lib/php
#COPY --from=builder /lib/lsb /lib/lsb
#COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
#COPY --from=builder /var/lib/apache2 /var/lib/apache2
#COPY --from=builder /var/www /var/www
#COPY --from=builder /var/log/apache2 /var/log/apache2
#
## Libraries need for Apache
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libaprutil-1.so.0 /usr/lib/x86_64-linux-gnu/libaprutil-1.so.0
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libapr-1.so.0 /usr/lib/x86_64-linux-gnu/libapr-1.so.0
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libargon2.so.1 /usr/lib/x86_64-linux-gnu/libargon2.so.1
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/x86_64-linux-gnu/libxml2.so.2
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libssl.so.1.1 /usr/lib/x86_64-linux-gnu/libssl.so.1.1
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0 /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libsodium.so.23 /usr/lib/x86_64-linux-gnu/libsodium.so.23
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libicui18n.so.63 /usr/lib/x86_64-linux-gnu/libicui18n.so.63
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libicuuc.so.63 /usr/lib/x86_64-linux-gnu/libicuuc.so.63
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libicudata.so.63 /usr/lib/x86_64-linux-gnu/libicudata.so.63
#
## Copy Nagios4
#COPY --from=builder /usr/share/nagios4 /usr/share/nagios4
#COPY --from=builder /usr/share/nagios4-cgi /usr/share/nagios4-cgi
#COPY --from=builder /var/lib/nagios4 /var/lib/nagios4
#COPY --from=builder /var/log/nagios4 /var/log/nagios4
#COPY --from=builder /usr/lib/cgi-bin/nagios4 /usr/lib/cgi-bin/nagios4
#COPY --from=builder /usr/lib/nagios /usr/lib/nagios
#COPY --from=builder /var/lib/nagios /var/lib/nagios
#
## Libraries need for Nagios4
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libltdl.so.7 /usr/lib/x86_64-linux-gnu/libltdl.so.7
#
## Copy system common 
#COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
#COPY --from=builder /etc /etc
#COPY --from=builder /usr/sbin /usr/sbin
#
##COPY start.sh /start.sh
##CMD /start.sh
