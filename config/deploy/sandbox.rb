set :stage, :sandbox
set :rails_env, 'sandbox'
set :ssh_options, { port: 2222 }
set :branch, 'c-bmros-test'

role :web, %w{deployer@localhost}
role :app, %w{deployer@localhost}
role :db,  %w{deployer@localhost}

server 'localhost', user: 'deployer', roles: %w{web app db}
