#!/bin/bash -xe

if [ ${DATABASE} = "mysql" ]; then
  export BUNDLE_WITHOUT="oracle postgresql sqlite3"

elif [ ${DATABASE} = "postgresql" ]; then
  export BUNDLE_WITHOUT="mysql oracle sqlite3"

elif [ ${DATABASE} = "sqlite3" ]; then
  export BUNDLE_WITHOUT="mysql oracle postgresql"

elif [ ${DATABASE} = "oracle" ]; then
  wget https://raw.githubusercontent.com/Vincit/travis-oracledb-xe/master/accept_the_license_agreement_for_oracledb_xe_11g_and_install.sh
  bash ./accept_the_license_agreement_for_oracledb_xe_11g_and_install.sh

  export BUNDLE_WITHOUT="mysql postgresql sqlite3"
fi

bundle install --without=${BUNDLE_WITHOUT} --path=${BUNDLE_PATH:-vendor/bundle} --retry=3 --jobs=3
