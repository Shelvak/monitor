set :application, 'monitor.mawidabp.com'
set :user, 'deployer'
set :repo_url, 'https://github.com/cirope/monitor.git'

set :format, :pretty
set :log_level, :error

set :deploy_to, "/var/www/#{fetch(:application)}"
set :deploy_via, :remote_cache

set :linked_files, %w{config/application.yml}
set :linked_dirs, %w{log public/uploads private tmp/pids}

set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'

set :keep_releases, 5

namespace :deploy do
  before :check,     'config:upload'
  after  :publishing, :restart
  after  :finishing,  'deploy:cleanup'
end
