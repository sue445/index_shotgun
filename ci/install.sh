#!/bin/bash -xe

if [ "${DATABASE}" = "mysql" ]; then
  apt-get update
  apt-get install -y libmariadb-dev

  BUNDLE_WITHOUT="oracle postgresql sqlite3"

elif [ "${DATABASE}" = "postgresql" ]; then
  apt-get update
  apt-get install -y libpq-dev

  BUNDLE_WITHOUT="mysql oracle sqlite3"

elif [ "${DATABASE}" = "sqlite3" ]; then
  apt-get update
  apt-get install -y libsqlite3-dev

  BUNDLE_WITHOUT="mysql oracle postgresql"

elif [ "${DATABASE}" = "oracle" ]; then
  # c.f. https://github.com/kubo/ruby-oci8/blob/ruby-oci8-2.2.7/docs/install-instant-client.md#install-oracle-instant-client-packages
  mkdir -p /opt/oracle
  pushd /opt/oracle

  wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip
  wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip

  unzip instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip
  unzip instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip

  apt-get update
  apt-get install -y libaio1

  popd

  BUNDLE_WITHOUT="mysql postgresql sqlite3"

else
  BUNDLE_WITHOUT="mysql postgresql sqlite3 oracle"

fi

bundle config path vendor/bundle
bundle config without $BUNDLE_WITHOUT
bundle install --path vendor/bundle/ --jobs $(nproc) --retry 3
bundle update --jobs $(nproc) --retry 3