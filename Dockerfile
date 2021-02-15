FROM ubuntu:20.04 AS builder

COPY stage1.sh .
RUN ./stage1.sh


FROM ubuntu:20.04 AS builder2

COPY stage2.sh .
RUN ./stage2.sh


FROM ubuntu:20.04

COPY --from=builder /usr/local/nagios /usr/local/nagios
COPY --from=builder2 /etc /etc
COPY --from=builder2 /usr/lib/ /usr/lib/
COPY --from=builder2 /usr/share /usr/share
COPY --from=builder2 /var/lib /var/lib



COPY start.sh .
CMD ./start.sh
