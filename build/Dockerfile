FROM maven:3-jdk-8-alpine

RUN addgroup -S -g 117 Jenkins \
   && adduser -S -D -u 111 -s /sbin/nologin -h /jenkins -g "Jenkins User" -G Jenkins jenkins

