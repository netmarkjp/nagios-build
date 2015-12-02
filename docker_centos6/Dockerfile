FROM centos:6

RUN yum -y groupinstall "Development Tools"
RUN yum -y install rpm-build gd-devel zlib-devel libpng-devel libjpeg-devel doxygen gperf
RUN yum -y install tar
RUN mkdir -p /root/rpmbuild/SOURCES
RUN mkdir /dest
COPY run.sh /run.sh

VOLUME ["/dest"]

ENTRYPOINT [ "/run.sh" ]
