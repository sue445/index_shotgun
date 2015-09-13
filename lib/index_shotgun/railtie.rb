module IndexShotgun
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require "index_shotgun/tasks"
    end
  end
end
