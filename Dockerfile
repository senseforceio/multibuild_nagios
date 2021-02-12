FROM debian:stable-slim AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

FROM debian:stable-slim
COPY --from=builder /usr/local/nagios /usr/local/nagios
# ENTRYPOINT ["/usr/local/nagios/bin/nagios", "/usr/local/nagios/etc/nagios.cfg"]
