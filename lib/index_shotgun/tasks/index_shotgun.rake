namespace :index_shotgun do
  desc "Search duplicate indexes"
  task :fire => :environment do
    puts IndexShotgun::Analyzer.perform
  end
end
