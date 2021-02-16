FROM ubuntu:20.04 AS nagios-builder

COPY stage1.sh .
RUN ./stage1.sh


FROM nagios-builder AS plugin-builder 

COPY stage2.sh .
RUN ./stage2.sh


FROM ubuntu:20:04 

COPY stage3.sh .
RUN ./stage3.sh
COPY --from=plugin-builder /usr/local/nagios /usr/local/nagios
COPY --from=plugin-builder /etc /etc
