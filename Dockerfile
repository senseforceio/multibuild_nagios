FROM ubuntu:20.04 AS builder

COPY stage1.sh .
RUN ./stage1.sh


FROM ubuntu:20.04

COPY stage2.sh .
RUN ./stage2.sh
COPY --from=builder /usr/local/nagios /usr/local/nagios
COPY --from=builder /etc /etc


COPY start.sh .
CMD ./start.sh
