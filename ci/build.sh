#!/bin/bash -xe

cp ci/database.yml.${DATABASE} spec/config/database.yml
bundle exec rspec
bundle exec codeclimate-test-reporter

bundle exec ./exe/index_shotgun version

#########################
set +e

if [ ${DATABASE} = "mysql" ]; then
  bundle exec ./exe/index_shotgun mysql --database=index_shotgun_test --username=travis
  RET=$?
elif [ ${DATABASE} = "postgresql" ]; then
  bundle exec ./exe/index_shotgun postgresql --database=index_shotgun_test --username=postgres
  RET=$?
elif [ ${DATABASE} = "sqlite3" ]; then
  bundle exec ./exe/index_shotgun sqlite3 --database=spec/db/index_shotgun_test.db
  RET=$?
elif [ ${DATABASE} = "oracle" ]; then
  bundle exec ./exe/index_shotgun oracle --database=xe --username=system --password=oracle
  RET=$?
fi

set -e
#########################

if [ $RET -ne 1 ]; then
  echo "Expect exit code is 1, but actual is ${RET}"
  exit 1
fi
