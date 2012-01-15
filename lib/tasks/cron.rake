desc "this task is called by the heroku cron add-on"
task :cron => :environment do
  PopularEntry.reload
end
