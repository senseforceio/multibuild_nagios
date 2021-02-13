FROM debian:stable-slim AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

FROM debian:stable-slim
COPY --from=builder /usr/local/nagios /usr/local/nagios
COPY --from=builder /usr/local/apache2 /usr/local/apache2
COPY --from=builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
COPY --from=builder /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
# ENTRYPOINT ["/usr/local/nagios/bin/nagios", "/usr/local/nagios/etc/nagios.cfg"]
