require "thor"
require "index_shotgun"
require "active_support/core_ext/hash"

module IndexShotgun
  class CLI < Thor
    desc "mysql", "Search duplicate indexes on MySQL"
    option :database, aliases: "d", required: true
    option :encoding, default: "utf8"
    option :pool, default: 5, type: :numeric
    option :host, aliases: "h", default: "localhost"
    option :port, aliases: "P", default: 3306, type: :numeric
    option :username, aliases: "u"
    option :password, aliases: "p"
    option :ask_password, default: false, type: :boolean
    def mysql
      analyze("mysql2")
    end

    desc "oracle", "Search duplicate indexes on Oracle"
    option :database, aliases: "d", required: true
    option :encoding, default: "utf8"
    option :pool, default: 5, type: :numeric
    option :host, aliases: "h", default: "localhost"
    option :port, aliases: "P", default: 1521, type: :numeric
    option :username, aliases: "u"
    option :password, aliases: "p"
    option :ask_password, default: false, type: :boolean
    def oracle
      analyze("oracle_enhanced", "activerecord-oracle_enhanced-adapter")
    end

    desc "postgresql", "Search duplicate indexes on PostgreSQL"
    option :database, aliases: "d", required: true
    option :encoding, default: "utf8"
    option :pool, default: 5, type: :numeric
    option :host, aliases: "h", default: "localhost"
    option :port, aliases: "P", default: 5432, type: :numeric
    option :username, aliases: "u"
    option :password, aliases: "p"
    option :ask_password, default: false, type: :boolean
    def postgresql
      analyze("postgresql", "pg")
    end

    desc "sqlite3", "Search duplicate indexes on sqlite3"
    option :database, aliases: "d", required: true
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

      ask_password = config.delete("ask_password")
      config[:password] = ask("Input password (hidden):", echo: false) if ask_password

      ActiveRecord::Base.establish_connection(config)
      response = IndexShotgun::Analyzer.perform
      puts response.message
      response.exit_if_failure!
    end
  end
end
