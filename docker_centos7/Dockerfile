FROM centos:7.2.1511

RUN yum -y groupinstall "Development Tools" && yum clean all

#  for nagios
RUN yum -y install rpm-build gd-devel zlib-devel libpng-devel libjpeg-devel doxygen gperf && yum clean all

# for nagios-plugins
RUN yum -y install \
        which \
        net-tools \
        postfix \
        bind-utils \
        mysql-devel \
        net-snmp-utils \
        ntp \
        openldap-devel \
        openssl-devel \
        postgresql-devel \
        samba-client \
        && yum clean all

RUN mkdir -p /root/rpmbuild/SOURCES
RUN mkdir /dest
COPY run.sh /run.sh

VOLUME ["/dest"]

ENTRYPOINT [ "/run.sh" ]
