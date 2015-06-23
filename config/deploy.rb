set :application, 'monitor.com'
set :user, 'deployer'
set :repo_url, 'git://github.com/cirope/monitor.git'

set :format, :pretty
set :log_level, :info

set :deploy_to, "/var/www/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :scm, :git

set :linked_files, %w{config/application.yml}
set :linked_dirs, %w{log}

set :rbenv_type, :user
set :rbenv_ruby, '2.2.1'

set :keep_releases, 5

namespace :deploy do
  after :publishing, :restart
  after :finishing,  'deploy:cleanup'
end
