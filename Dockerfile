FROM alpine:latest
MAINTAINER Bryce Thomsen
RUN apk update
RUN apk -v --update add \
        python \
        py-pip \
        && \
    pip install --upgrade awscli
RUN apk -v --purge del py-pip && \
    rm /var/cache/apk/*
