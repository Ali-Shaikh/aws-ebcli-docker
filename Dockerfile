FROM python:3.9-alpine

LABEL maintainer="Ali Shaikh <me@alishaikh.net>"

RUN apk add --no-cache --update --virtual .build-deps \
        build-base \
        libressl-dev \
        libffi-dev \
        && apk add --no-cache --update \
        bash \
        less \
        groff \
        jq \
        git \
        curl \
        openssh \
        && pip install --no-cache-dir --upgrade pip \
        awsebcli \
        awscli \
        && apk del .build-deps

ENV PAGER="less"

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Expose AWS credentials volume
RUN mkdir ~/.aws

RUN aws --version

RUN eb --version
