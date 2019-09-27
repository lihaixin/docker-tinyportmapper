FROM alpine:3.8
ARG tinyPortMapper_VER=20180224.0
ENV TZ=Asia/Shanghai

ENV L_ADDR 0.0.0.0:5001
ENV R_ADDR 8.8.8.8:5001
ENV OPTIONS "-t -u --log-level 4 --sock-buf 1024"

WORKDIR /home
RUN apk add -U tzdata \
        && wget https://github.com/wangyu-/tinyPortMapper/releases/download/$tinyPortMapper_VER/tinymapper_binaries.tar.gz -O tinymapper_binaries.tar.gz \
        && tar -zxvf tinymapper_binaries.tar.gz \
        && find ./ -type f -not -name tinymapper_amd64 -delete \
        && mv tinymapper_amd64 /usr/bin/tinymapper

EXPOSE 5001/tcp
EXPOSE 5001/udp

CMD /usr/bin/tinymapper \
              -l "$L_ADDR" \
              -r "$R_ADDR" \
              $OPTIONS
