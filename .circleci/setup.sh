#!/bin/bash -xe

gem install bundler --no-document

ruby --version
bundle --version
gem --version

bundle check || bundle install --without ${BUNDLE_WITHOUT} --path=${BUNDLE_PATH:-vendor/bundle}
bundle clean
