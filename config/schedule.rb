every 1.minutes do
  runner 'Schedule.schedule; Run.schedule'
end

every 30.minutes do
  command "cd #{path} && cap localhost sidekiq:restart"
end
