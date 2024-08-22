FROM ubuntu:23.10

LABEL maintainer="Gatsby Huang <jchuang@agioe.com>"

COPY container-setup-amd64.sh /usr/local/bin/container-setup-amd64
COPY container-setup-common.sh /usr/local/bin/container-setup-common

# set default locale
# ENV LANG zh_CN.UTF-8
ENV LANG en_US.UTF-8

RUN /usr/local/bin/container-setup-amd64

USER cs144-user

WORKDIR /home/cs144-user
CMD ["/bin/bash", "-l"]
