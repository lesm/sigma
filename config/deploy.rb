# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "sigma"
set :repo_url, "git@bitbucket.org:oaxteam/sigma.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/apps/sigma"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key', 'config/credentials.yml.enc')

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
set :default_env, { path: "/home/deployer/.nvm/versions/node/v10.14.1/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end

#after 'deploy:publishing', 'deploy:restart'
#namespace :deploy do

  #desc 'Restart application'
  #task :restart do
    #invoke 'unicorn:restart'
  #end

  #after :restart, :clear_cache do
    #on roles(:web), in: :groups, limit: 3, wait: 10 do
    #end
  #end

  #after :finishing, 'deploy:cleanup'
#end

