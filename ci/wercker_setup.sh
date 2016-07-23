#!/bin/bash -xe

apt-get update
apt-get install -y ruby2.3 ruby2.3-dev git build-essential
gem update --system --no-document

/usr/sbin/startup.sh
/etc/init.d/oracle-xe status
