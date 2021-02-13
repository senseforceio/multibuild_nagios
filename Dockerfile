FROM alpine:latest AS builder

COPY install-packages.sh .
RUN ./install-packages.sh
