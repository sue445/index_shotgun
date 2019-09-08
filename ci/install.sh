#!/bin/bash -xe

gem update --system
gem install bundler --no-document -v 1.17.3 || true

if [ "${DATABASE}" = "mysql" ]; then
  sudo apt-get update
  sudo apt-get install -y libmysqlclient-dev

  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without oracle postgresql sqlite3

elif [ "${DATABASE}" = "postgresql" ]; then
  sudo apt-get update
  sudo apt-get install -y libpq-dev

  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql oracle sqlite3

elif [ "${DATABASE}" = "sqlite3" ]; then
  sudo apt-get update
  sudo apt-get install -y libsqlite3-dev

  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql oracle postgresql

elif [ "${DATABASE}" = "oracle" ]; then
  # c.f. https://github.com/kubo/ruby-oci8/blob/ruby-oci8-2.2.7/docs/install-instant-client.md#install-oracle-instant-client-packages
  mkdir -p /opt/oracle
  pushd /opt/oracle

  wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip
  wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip

  unzip instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip
  unzip instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip

  sudo apt-get update
  sudo apt-get install -y libaio1

  popd

  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql postgresql sqlite3

else
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql postgresql sqlite3 oracle

fi
