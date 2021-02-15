FROM ubuntu:20.04 AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

COPY start.sh /start.sh
CMD /start.sh
