env :PATH, ENV['PATH']

every 5.minutes do
  runner 'Schedule.schedule; Run.schedule'
end

every 1.day do
  rake 'sessions:clear'
end
