#!/bin/bash

set -e

NAGIOS_VERSION=${1:-4.2.3}

echo NAGIOS_VERSION: ${NAGIOS_VERSION:?}

cd /tmp
curl -kL https://github.com/NagiosEnterprises/nagioscore/archive/release-${NAGIOS_VERSION}.tar.gz | tar zxf -
mv nagioscore-release-${NAGIOS_VERSION} nagios-${NAGIOS_VERSION}
tar zcfp /root/rpmbuild/SOURCES/nagios-${NAGIOS_VERSION}.tar.gz nagios-${NAGIOS_VERSION}
rpmbuild -bb /tmp/nagios-${NAGIOS_VERSION}/nagios.spec
cp -a /root/rpmbuild/RPMS/* /dest/.
