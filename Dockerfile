FROM phusion/baseimage:master-amd64 AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

# Multi-stage build
FROM phusion/baseimage:master-amd64

# Copy Apache
COPY --from=builder /usr/lib/apache2 /usr/lib/apache2
COPY --from=builder /usr/lib/php /usr/lib/php
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
COPY --from=builder /lib/lsb /lib/lsb
COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
COPY --from=builder /var/lib/apache2 /var/lib/apache2
COPY --from=builder /var/www /var/www
COPY --from=builder /var/log/apache2 /var/log/apache2
COPY --from=builder /usr/sbin /usr/sbin

# Copy Nagios
COPY --from=builder /usr/local/nagios /usr/local/nagios

# Copy system etc
COPY --from=builder /etc /etc

# Copy awk, need for plugins
#COPY --from=builder /usr/bin/awk /usr/bin/awk
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libsigsegv.so.2 /usr/lib/x86_64-linux-gnu/libsigsegv.so.2
#COPY --from=builder /usr/lib/x86_64-linux-gnu/libmpfr.so.6 /usr/lib/x86_64-linux-gnu/libmpfr.so.6

#COPY start.sh . 
#CMD /start.sh
