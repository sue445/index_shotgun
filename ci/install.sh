#!/bin/bash -xe

gem update --system
gem install bundler --no-document -v 1.17.3 || true

if [ "${DATABASE}" = "mysql" ]; then
  sudo apt-get update
  sudo apt-get install -y libmysqlclient-dev

  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without oracle postgresql sqlite3

elif [ "${DATABASE}" = "postgresql" ]; then
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql oracle sqlite3

elif [ "${DATABASE}" = "sqlite3" ]; then
  sudo apt-get update
  sudo apt-get install -y libsqlite3-dev

  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql oracle postgresql

elif [ "${DATABASE}" = "oracle" ]; then
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql postgresql sqlite3

else
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql postgresql sqlite3 oracle

fi
