#!/bin/bash -xe

cp travis_ci/database.yml.${DATABASE} spec/config/database.yml
bundle exec rspec
