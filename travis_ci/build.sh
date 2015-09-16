#!/bin/bash -xe

cp travis_ci/database.yml.${DATABASE} spec/config/database.yml
bundle exec rspec

bundle exec ./exe/index_shotgun version

if [ ${DATABASE} = "mysql" ]; then
  bundle exec ./exe/index_shotgun mysql --database=index_shotgun_test --username=travis
elif [ ${DATABASE} = "postgresql" ]; then
  bundle exec ./exe/index_shotgun postgresql --database=index_shotgun_test --username=postgres
elif [ ${DATABASE} = "sqlite3" ]; then
  bundle exec ./exe/index_shotgun sqlite3 --database=spec/db/index_shotgun_test.db
fi
