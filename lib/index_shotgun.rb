require "index_shotgun/version"
require "index_shotgun/analyzer"
require "active_record"

module IndexShotgun
  # Your code goes here...
end

require "index_shotgun/railtie" if defined?(Rails)

begin
  require "mysql2/version"

  if Gem::Version.create(Mysql2::VERSION) >= Gem::Version.create("0.4.0") &&
    ActiveRecord.version < Gem::Version.create("4.2.5")
    raise "Requirements activerecord gem v4.2.5+ when using mysql2 gem v0.4.0+"
  end

rescue LoadError
end
