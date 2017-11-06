set :stage, :production
set :rails_env, 'production'
set :branch, 'new-init'

role :web, %w{deployer@demo.greditsoft.com}
role :app, %w{deployer@demo.greditsoft.com}
role :db,  %w{deployer@demo.greditsoft.com}

server 'demo.greditsoft.com', user: 'deployer', roles: %w{web app db}
