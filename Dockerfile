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
        && apk --no-cache add \
        binutils \
        && GLIBC_VER=$(curl -s https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest | grep tag_name | cut -d : -f 2,3 | tr -d \",' ') \
        && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
        && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
        && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
        && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
        && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
        && unzip awscliv2.zip \
        && aws/install \
        && pip install --no-cache-dir --upgrade pip \
        awsebcli \
        && apk del .build-deps \
        && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
        && apk --no-cache del \
        binutils \
        && rm glibc-${GLIBC_VER}.apk \
        && rm glibc-bin-${GLIBC_VER}.apk \
        && rm -rf /var/cache/apk/*

ENV PAGER="less"

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Expose AWS credentials volume
RUN mkdir ~/.aws

RUN aws --version

RUN eb --version
