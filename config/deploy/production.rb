set :stage, :production
set :rails_env, 'production'
set :branch, 'pae'

role :web, %w{deployer@pae.greditsoft.com}
role :app, %w{deployer@pae.greditsoft.com}
role :db,  %w{deployer@pae.greditsoft.com}

server 'pae.greditsoft.com', user: 'deployer', roles: %w{web app db}
