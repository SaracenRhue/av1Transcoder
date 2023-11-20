FROM alpine:latest

RUN apk add --no-cache ffmpeg parallel

ENV INPUT_DIR=/input
ENV OUTPUT_DIR=/output

COPY transcode.sh /usr/local/bin/transcode.sh
RUN chmod +x /usr/local/bin/transcode.sh

WORKDIR $INPUT_DIR

CMD ["/usr/local/bin/transcode.sh"]
