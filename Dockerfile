FROM debian:buster-slim AS builder

COPY stage1.sh .
RUN ./stage1.sh


FROM debian:buster-slim

COPY stage2.sh .
RUN ./stage2.sh
COPY --from=builder /usr/local/nagios /usr/local/nagios
COPY --from=builder /etc /etc


COPY start.sh .
CMD ./start.sh
