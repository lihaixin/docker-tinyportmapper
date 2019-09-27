FROM alpine:3.8
ARG tinyPortMapper_VER=20180224.0
ENV TZ=Asia/Shanghai

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 61080
ENV METHOD      xchacha20-ietf-poly1305
ENV PASSWORD	pwd
ENV TIMEOUT     300
ENV DNS_ADDR    8.8.8.8
ENV OPTIONS	-v

RUN apk add -U tzdata \
        && wget $UDPSPEEDER_DL_ADRESS -O $UDPSPEEDER_FILE_NAME \
        && tar -zxvf $UDPSPEEDER_FILE_NAME \
        && find ./ -type f -not -name "$UDPSPEEDER_BIN_NAME" -delete \
        && mv "/home/$UDPSPEEDER_BIN_NAME" /usr/bin/speederv2 \

EXPOSE $SERVER_PORT/tcp
EXPOSE $SERVER_PORT/udp


CMD httpd-server -s "$SERVER_ADDR" \
              -p "$SERVER_PORT" \
              -m "$METHOD"      \
              -k "$PASSWORD"    \
              -t "$TIMEOUT"     \
              -d "$DNS_ADDR"    \
              -u                \
              --fast-open $OPTIONS
