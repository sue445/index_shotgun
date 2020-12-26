ActiveRecord::Base.configurations = YAML.load(ERB.new(File.read("#{__dir__}/../config/database.yml")).result).with_indifferent_access

test_configuration =
  if ActiveRecord.gem_version >= Gem::Version.new("6.1.0")
    ActiveRecord::Base.configurations.configs_for(env_name: "test")[0]
  else
    ActiveRecord::Base.configurations["test"]
  end

ActiveRecord::Base.establish_connection(test_configuration)

require "active_record/tasks/database_tasks"

module Rails
  def self.root
    Pathname("#{__dir__}/../")
  end
end

# db:drop
ActiveRecord::Tasks::DatabaseTasks.drop(test_configuration) unless ENV["CI"]

# db:create
ActiveRecord::Tasks::DatabaseTasks.create(test_configuration)

require_relative "../db/migrations"
