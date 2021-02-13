FROM debian:stable-slim AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

FROM debian:stable-slim
COPY --from=builder /usr/local/nagios /usr/local/nagios
COPY --from=builder /etc/apache2 /etc/apache2
COPY --from=builder /lib/systemd/system /lib/systemd/system
COPY --from=builder /etc/apache2 /etc/apache2
COPY --from=builder /usr/sbin /usr/sbin
COPY --from=builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
COPY --from=builder /usr/lib/apache2 /usr/lib/apache2
COPY --from=builder /var/log/apache2 /var/log/apache2
# ENTRYPOINT ["/usr/local/nagios/bin/nagios", "/usr/local/nagios/etc/nagios.cfg"]
