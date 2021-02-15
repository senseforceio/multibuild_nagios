FROM ubuntu:20.04 AS builder

COPY stage1.sh .
RUN ./stage1.sh
