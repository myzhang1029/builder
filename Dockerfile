# 
# aredn/builder
#

FROM ubuntu:xenial
MAINTAINER dman776@gmail.com
ENV IMAGE=arednmesh/builder \
    AREDNUSER=aredn \
    AREDNDIR=/opt/aredn

RUN apt-get update && apt-get install -y \
    git \
    subversion \
    build-essential \
    libncurses5-dev \
    zlib1g-dev \
    gawk \
    unzip \
    libxml-perl \
    flex \
    curl \
    wget \
    gettext \
    quilt \
    python \
    libssl-dev \
    shellcheck \
    lua5.1 \
    vim-tiny \
    nano \
    bc \
    htop \
    sudo \
    rsync \
    time

RUN useradd -m ${AREDNUSER} && echo "${AREDNUSER}:${AREDNUSER}" | chpasswd && adduser ${AREDNUSER} sudo

RUN mkdir -p ${AREDNDIR} \
    && chown ${AREDNUSER}:${AREDNUSER} ${AREDNDIR}

COPY motd /etc/motd
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/issue && cat /etc/motd' >> /etc/bash.bashrc

USER ${AREDNUSER}
WORKDIR ${AREDNDIR}
RUN git clone http://github.com/aredn/aredn_ar71xx
WORKDIR ${AREDNDIR}/aredn_ar71xx


