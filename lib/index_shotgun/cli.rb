require "thor"
require "index_shotgun"
require "active_support/core_ext/hash"

module IndexShotgun
  class CLI < Thor
    desc "mysql", "Search duplicate indexes on MySQL"
    option :database, required: true
    option :encoding, default: "utf8"
    option :pool, default: 5, type: :numeric
    option :host, default: "localhost"
    option :port, default: 3306, type: :numeric
    option :username
    option :password
    def mysql
      analyze("mysql2")
    end

    desc "postgresql", "Search duplicate indexes on PostgreSQL"
    option :database, required: true
    option :encoding, default: "utf8"
    option :pool, default: 5, type: :numeric
    option :host, default: "localhost"
    option :port, default: 5432, type: :numeric
    option :username
    option :password
    def postgresql
      analyze("postgresql", "pg")
    end

    desc "sqlite3", "Search duplicate indexes on sqlite3"
    option :database, required: true
    def sqlite3
      analyze("sqlite3")
    end

    desc "version", "Show index_shotgun version"
    def version
      puts IndexShotgun::VERSION
    end

    private

    def analyze(adapter_name, gem_name = nil)
      gem_name ||= adapter_name
      begin
        require gem_name
      rescue LoadError
        puts "[ERROR] #{adapter_name} is not installed. Please run `gem install #{gem_name}` and install gem"
        exit!
      end

      config = options.reverse_merge(adapter: adapter_name)
      ActiveRecord::Base.establish_connection(config)
      puts IndexShotgun::Analyzer.perform
    end
  end
end
