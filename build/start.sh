#!/bin/sh

java \
    -server \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+UseCGroupMemoryLimitForHeap \
    -XX:MaxRAMFraction=2 \
    -XX:+UseG1GC \
    -Dsun.net.inetaddr.ttl=30 \
    -jar /usr/share/bigtable-autoscaler/bigtable-autoscaler.jar \
    "$@"
