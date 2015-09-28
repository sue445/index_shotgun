# IndexShotgun :fire: :gun: :cop:
[![Gem Version](https://badge.fury.io/rb/index_shotgun.svg)](http://badge.fury.io/rb/index_shotgun)
[![Build Status](https://travis-ci.org/sue445/index_shotgun.svg?branch=master)](https://travis-ci.org/sue445/index_shotgun)
[![Code Climate](https://codeclimate.com/github/sue445/index_shotgun/badges/gpa.svg)](https://codeclimate.com/github/sue445/index_shotgun)
[![Coverage Status](https://coveralls.io/repos/sue445/index_shotgun/badge.svg?branch=master&service=github)](https://coveralls.io/github/sue445/index_shotgun?branch=master)
[![Dependency Status](https://gemnasium.com/sue445/index_shotgun.svg)](https://gemnasium.com/sue445/index_shotgun)

Duplicate index checker. 

This like [pt-duplicate-key-checker](https://www.percona.com/doc/percona-toolkit/2.1/pt-duplicate-key-checker.html), but also supports database other than MySQL

## Example
```sh
$ index_shotgun postgresql --database=index_shotgun_test
# =============================
# user_stocks
# =============================

# index_user_stocks_on_user_id is a left-prefix of index_user_stocks_on_user_id_and_article_id
# To remove this duplicate index, execute:
ALTER TABLE `user_stocks` DROP INDEX `index_user_stocks_on_user_id`;

# =============================
# user_stocks
# =============================

# index_user_stocks_on_user_id_and_article_id_and_already_read has column(s) on the right side of unique index (index_user_stocks_on_user_id_and_article_id). You can drop if low cardinality
# To remove this duplicate index, execute:
ALTER TABLE `user_stocks` DROP INDEX `index_user_stocks_on_user_id_and_article_id_and_already_read`;

# =============================
# user_stocks
# =============================

# index_user_stocks_on_user_id is a left-prefix of index_user_stocks_on_user_id_and_article_id_and_already_read
# To remove this duplicate index, execute:
ALTER TABLE `user_stocks` DROP INDEX `index_user_stocks_on_user_id`;

# ########################################################################
# Summary of indexes
# ########################################################################

# Total Duplicate Indexes  3
# Total Indexes            6
# Total Tables             5
```

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'index_shotgun'
end
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install index_shotgun
```

If you want to use as commandline tool, you need to install these gems.

```sh
# MySQL
$ gem install mysql2 -v 0.3.20

# PostgreSQL
$ gem install pg

# sqlite3
$ gem install sqlite3
```

**Details:** `index_shotgun` does not yet support `mysql2` v0.4+

## Usage
### Ruby app

```sh
$ bundle exec rake index_shotgun:fire
```

run `fire` :fire: task

If you don't use Rails app, append this to `Rakefile`

```ruby
require "index_shotgun/tasks"
```

### Command line
Support these commands

```sh
$ index_shotgun
Commands:
  index_shotgun help [COMMAND]                  # Describe available commands or one specific command
  index_shotgun mysql --database=DATABASE       # Search duplicate indexes on MySQL
  index_shotgun postgresql --database=DATABASE  # Search duplicate indexes on PostgreSQL
  index_shotgun sqlite3 --database=DATABASE     # Search duplicate indexes on sqlite3
  index_shotgun version                         # Show index_shotgun version
```

**Details:** check `index_shotgun help <database>`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec index_shotgun` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/index_shotgun.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## FAQ
### Q. The origin of the name?
A. **Index Shotgun** is one of SQL Antipatterns.

https://pragprog.com/book/bksqla/sql-antipatterns
