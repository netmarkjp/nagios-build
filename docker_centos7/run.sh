#!/bin/bash

set -e

NAGIOS_VERSION=${1:-4.1.0}

echo NAGIOS_VERSION: ${NAGIOS_VERSION:?}

cd /tmp
curl -kLO https://github.com/NagiosEnterprises/nagioscore/archive/nagios-${NAGIOS_VERSION}.tar.gz
tar zxf nagios-${NAGIOS_VERSION}.tar.gz
mv nagioscore-nagios-${NAGIOS_VERSION} nagios-${NAGIOS_VERSION}
tar zcfp /root/rpmbuild/SOURCES/nagios-${NAGIOS_VERSION}.tar.gz nagios-${NAGIOS_VERSION}
rpmbuild -bb /tmp/nagios-${NAGIOS_VERSION}/nagios.spec
cp -a /root/rpmbuild/RPMS/* /dest/.

