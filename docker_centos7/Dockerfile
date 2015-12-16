FROM centos:7

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y groupinstall "Development Tools"
RUN yum -y install rpm-build gd-devel zlib-devel libpng-devel libjpeg-devel doxygen gperf
RUN yum clean all
RUN mkdir -p /root/rpmbuild/SOURCES
RUN mkdir /dest
COPY run.sh /run.sh

VOLUME ["/dest"]

ENTRYPOINT [ "/run.sh" ]
