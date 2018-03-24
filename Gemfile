source "https://rubygems.org"

# Specify your gem's dependencies in index_shotgun.gemspec
gemspec

group :postgresql do
  gem "pg"
end

group :mysql do
  gem "mysql2"
end

eval(Pathname("gemfiles/common.gemfile").read)
