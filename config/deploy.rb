require "bundler/capistrano"
require "rvm/capistrano"
require "./config/boot"
require "airbrake/capistrano"

set :rvm_ruby_string, :local

before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
before 'deploy:setup', 'rvm:install_ruby'

server "192.241.217.183", :web, :app, :db, primary: true

set :application, "plentus-pre-launch"
set :user, "deploy"
set :port, 222
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "https://github.com/jongirard/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:port] = 222


namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
    desc "reload the database with seed data"
      task :seed do
        run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
      end
  end
  
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

after "deploy", "figaro:setup", "figaro:finalize"
after "deploy:cold", "deploy:seed"

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    transfer :up, "config/application.yml", "#{shared_path}/application.yml", :via => :scp
  end
 
  desc "Symlink application.yml to the release path"
  task :finalize do
    run "ln -sf #{shared_path}/application.yml #{current_path}/config/application.yml"
  end
end
