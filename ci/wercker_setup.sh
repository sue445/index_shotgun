#!/bin/bash -xe

apt-get update
apt-get install -y ruby2.3 ruby2.3-dev git build-essential curl

# gem update --system --no-document
# FIXME If update to latest rubygems, occurred following error.
#
# root@49a23aa43fcd:/# gem update --system --no-document
# Updating rubygems-update
# Fetching: rubygems-update-2.7.5.gem (100%)
# Successfully installed rubygems-update-2.7.5
# Installing RubyGems 2.7.5
# Bundler 1.16.1 installed
# RubyGems 2.7.5 installed
# Regenerating binstubs
# `/usr/share/rubygems-integration/all/gems/rake-10.5.0/bin/rake` does not exist, maybe `gem pristine rake` will fix it?
#
# root@49a23aa43fcd:/# gem instal bundler
# Fetching: bundler-1.16.1.gem (100%)
# Successfully installed bundler-1.16.1
# Parsing documentation for bundler-1.16.1
# Installing ri documentation for bundler-1.16.1
# Done installing documentation for bundler after 4 seconds
# 1 gem installed
# root@49a23aa43fcd:/# bundle -v
# /usr/local/bin/bundle:23:in `load': cannot load such file -- /usr/lib/ruby/gems/2.3.0/gems/bundler-1.16.1/exe/bundle (LoadError)
# 	from /usr/local/bin/bundle:23:in `<main>'
#
# c.f. https://app.wercker.com/sue445/index_shotgun/runs/build-oracle/5a7da0c534645f0001a806ed?step=5a7da0f8da96a80001949d1d
#
# This is the same phenomenon as below
# https://github.com/rubygems/rubygems/issues/2071

/usr/sbin/startup.sh
/etc/init.d/oracle-xe status
