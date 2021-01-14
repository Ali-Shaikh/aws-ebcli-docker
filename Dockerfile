FROM alpine

LABEL maintainer="Ali Shaikh <me@alishaikh.net>"

RUN apk --no-cache --update add \
        bash \
        less \
        groff \
        jq \
        git \
        curl \
        python \
        py-pip

RUN pip install --upgrade pip \
        awsebcli \
        awscli

ENV PAGER="less"

# Expose AWS credentials volume
RUN mkdir ~/.aws