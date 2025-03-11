# 
# aredn/builder
#

FROM ubuntu:noble
MAINTAINER me@maiyun.me
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
    python3 \
    python-is-python3 \
    libssl-dev \
    shellcheck \
    lua5.1 \
    vim \
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
RUN git clone http://github.com/aredn/aredn.git
WORKDIR ${AREDNDIR}/aredn
