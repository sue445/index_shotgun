#!/bin/bash -xe

if [ ${DATABASE} = "mysql" ]; then
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without oracle postgresql sqlite3

elif [ ${DATABASE} = "postgresql" ]; then
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql oracle sqlite3

elif [ ${DATABASE} = "sqlite3" ]; then
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql oracle postgresql

elif [ ${DATABASE} = "oracle" ]; then
  bundle install --path vendor/bundle/ --jobs 4 --retry 3 --without mysql postgresql sqlite3

fi
