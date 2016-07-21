namespace :index_shotgun do
  desc "Search duplicate indexes"
  task :fire => :environment do
    response = IndexShotgun::Analyzer.perform
    puts response.message
    response.exit_if_failure!
  end
end
