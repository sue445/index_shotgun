ActiveRecord::Base.configurations = YAML.load_file("#{__dir__}/../config/database.yml").with_indifferent_access

test_configuration = ActiveRecord::Base.configurations["test"]
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
