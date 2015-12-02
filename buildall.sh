#!/bin/bash

set -e

NAGIOS_VERSION=$1

ROOT_DIR=$(dirname $0)
cd ${ROOT_DIR:?}
DOCKER_DIRS=$(ls -d docker_*)

for DOCKER_DIR in ${DOCKER_DIRS:?}
do
  echo ${DOCKER_DIR:?}
  cd ${DOCKER_DIR:?}
  docker build -t netmarkjp/nagios-build:${DOCKER_DIR} .
  cd ..
  mkdir -p tmp/${DOCKER_DIR:?} || true
  docker run --rm -v `pwd`/tmp/${DOCKER_DIR:?}:/dest netmarkjp/nagios-build:${DOCKER_DIR} ${NAGIOS_VERSION}
done

#for DOCKER_DIR in ${DOCKER_DIRS:?}
#do
#  echo ${DOCKER_DIR:?}
#  cd ..
#done
