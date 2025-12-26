#!/bin/bash -xe

gem update --system --quiet || true

gem --version
bundle --version

if [ "${DATABASE}" = "mysql" ]; then
  sudo apt-get update
  sudo apt-get install -y libmysqlclient-dev

  bundle config set --local without "postgresql sqlite3 oracle"

elif [ "${DATABASE}" = "postgresql" ]; then
  sudo apt-get update
  sudo apt-get install -y libpq-dev

  bundle config set --local without "mysql sqlite3 oracle"

elif [ "${DATABASE}" = "sqlite3" ]; then
  sudo apt-get update
  sudo apt-get install -y libsqlite3-dev

  bundle config set --local without "mysql postgresql oracle"

elif [ "${DATABASE}" = "oracle" ]; then
  # c.f. https://github.com/kubo/ruby-oci8/blob/ruby-oci8-2.2.7/docs/install-instant-client.md#install-oracle-instant-client-packages
  mkdir -p /opt/oracle
  pushd /opt/oracle

  wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip
  wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip

  unzip instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip
  unzip instantclient-sdk-linux.x64-19.3.0.0.0dbru.zip

  sudo apt-get update

  # libaio1 is replaced to libaio1t64
  # c.f. https://askubuntu.com/questions/1512196/libaio1-on-noble
  # sudo apt-get install -y libaio1
  sudo apt-get install -y libaio1t64
  sudo ln -s /usr/lib/$(uname -m)-linux-gnu/libaio.so.1t64 /usr/lib/$(uname -m)-linux-gnu/libaio.so.1

  popd

  bundle config set --local without "mysql postgresql sqlite3"

elif [ "${DATABASE}" = "sqlite3" ]; then
  bundle config set --local without "mysql postgresql oracle"

else
  bundle config set --local without "mysql postgresql sqlite3 oracle"

fi

bundle config set --local path "vendor/bundle/"
bundle update --all --jobs $(nproc) --retry 3
