#!/bin/bash -xe

if [ "${DATABASE}" = "mysql" ]; then
  export BUNDLE_WITHOUT="postgresql sqlite3 oracle"
elif [ "${DATABASE}" = "postgresql" ]; then
  export BUNDLE_WITHOUT="mysql sqlite3 oracle"
elif [ "${DATABASE}" = "sqlite3" ]; then
  export BUNDLE_WITHOUT="mysql postgresql oracle"
elif [ "${DATABASE}" = "oracle" ]; then
  export BUNDLE_WITHOUT="mysql postgresql sqlite3"
else
  echo "${DATABASE} is unknown"
  exit 1
fi

cp ci/database.yml.${DATABASE} spec/config/database.yml
bundle exec rspec --profile

bundle exec ./exe/index_shotgun version

#########################
set +e

if [ ${DATABASE} = "mysql" ]; then
  bundle exec ./exe/index_shotgun mysql --database=index_shotgun_test --username=root --password=root --port=$MYSQL_PORT
  RET=$?
elif [ ${DATABASE} = "postgresql" ]; then
  bundle exec ./exe/index_shotgun postgresql --database=index_shotgun_test --username=postgres --password=postgres --port=$POSTGRESQL_PORT
  RET=$?
elif [ ${DATABASE} = "sqlite3" ]; then
  bundle exec ./exe/index_shotgun sqlite3 --database=spec/db/index_shotgun_test.db
  RET=$?
elif [ ${DATABASE} = "oracle" ]; then
  bundle exec ./exe/index_shotgun oracle --database=xe --username=system --password=oracle --port=$ORACLE_PORT
  RET=$?
fi

set -e
#########################

if [ $RET -ne 1 ]; then
  echo "Expect exit code is 1, but actual is ${RET}"
  exit 1
fi
