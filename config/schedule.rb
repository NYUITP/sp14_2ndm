# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, "development"
#set :output, {:error => "/var/log/syslog.log", :standard => "/var/log/syslog.log"}

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every '* * * * *' do
  rake "my_namespace:poll"
  rake "s_namespace:trigger"
  #rake "s_namespace:priceHistory"
#%x(bundle exec rake s_namespace:priceHistory)
#Rake::Task['s_namespace:priceHistory'].execute

end
