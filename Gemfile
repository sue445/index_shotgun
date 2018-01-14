source "https://rubygems.org"

# Specify your gem's dependencies in index_shotgun.gemspec
gemspec

group :postgresql do
  gem "pg"
end

eval(Pathname("gemfiles/common.gemfile").read) # rubocop:disable Security/Eval
