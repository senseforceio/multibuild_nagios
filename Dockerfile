FROM debian:stable-slim AS builder

COPY install-packages.sh .
RUN ./install-packages.sh

# Multi-stage build
#FROM debian:stable-slim

#COPY start.sh /start.sh
#CMD /start.sh
