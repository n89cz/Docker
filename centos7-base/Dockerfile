FROM centos:7

MAINTAINER Martin Dusek <dusek@n89.cz>

RUN yum update -y

RUN yum -y install \
    mc \
    epel-release \
    git \
    net-tools \
    wget \
    unzip \
    iotop \
    ntp \
    postfix \
    iotop \
    tcpdump \
    curl \
    sysstat \
    rsyslog && \
    yum clean all && \
    rm -rf /var/cache/yum
