FROM ubuntu:20.04 AS builder

COPY install-packages.sh .
RUN ./install-packages.sh


FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade && \
    apt-get install apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /etc /etc
COPY --from=builder /usr/local/nagios /usr/local/nagios
