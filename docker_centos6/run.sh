#!/bin/bash

set -e

NAGIOS_VERSION=${1:-4.2.3}
PLUGIN_VERSION=${2:-2.1.4}

echo NAGIOS_VERSION: ${NAGIOS_VERSION:?}
echo PLUGIN_VERSION: ${PLUGIN_VERSION:?}

# Nagios
cd /tmp
curl -kL https://github.com/NagiosEnterprises/nagioscore/archive/release-${NAGIOS_VERSION}.tar.gz | tar zxf -
mv nagioscore-release-${NAGIOS_VERSION} nagios-${NAGIOS_VERSION}
tar zcfp /root/rpmbuild/SOURCES/nagios-${NAGIOS_VERSION}.tar.gz nagios-${NAGIOS_VERSION}
rpmbuild -bb /tmp/nagios-${NAGIOS_VERSION}/nagios.spec

# Plugins
cd /tmp
curl -kL https://github.com/nagios-plugins/nagios-plugins/archive/release-${PLUGIN_VERSION}.tar.gz | tar zxf -
mv nagios-plugins-release-${PLUGIN_VERSION} nagios-plugins-${PLUGIN_VERSION}
cd nagios-plugins-${PLUGIN_VERSION}
./tools/setup
./configure \
  --build=x86_64-redhat-linux-gnu \
  --host=x86_64-redhat-linux-gnu \
  --prefix=/usr \
  --exec-prefix=/usr \
  --bindir=/usr/bin \
  --sbindir=/usr/sbin \
  --sysconfdir=/etc \
  --datadir=/usr/share \
  --includedir=/usr/include \
  --libdir=/usr/lib64 \
  --libexecdir=/usr/libexec \
  --localstatedir=/var \
  --sharedstatedir=/var/lib \
  --mandir=/usr/share/man \
  --infodir=/usr/share/info \
  --datadir=/usr/share/nagios \
  --libexecdir=/usr/lib64/nagios/plugins \
  --localstatedir=/var/nagios \
  --sbindir=/usr/lib64/nagios/cgi \
  --sysconfdir=/etc/nagios \
  --with-cgiurl=/nagios/cgi-bin \
  --with-nagios-user=nagios \
  --with-nagios-group=nagios
cd ..
tar zcfp /root/rpmbuild/SOURCES/nagios-plugins-${PLUGIN_VERSION}.tar.gz nagios-plugins-${PLUGIN_VERSION}
rpmbuild -bb /tmp/nagios-plugins-${PLUGIN_VERSION}/nagios-plugins.spec

cp -a /root/rpmbuild/RPMS/* /dest/.
