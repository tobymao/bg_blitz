set :application, 'bg_blitz'
set :repo_url, 'git@github.com:tobymao/bg_blitz.git'
set :deploy_to, '/home/deploy/apps/bg_blitz'
set :current_dir, "#{fetch(:deploy_to)}/current"
set :tmp_dir, "#{fetch(:deploy_to)}/tmp"
set :ssh_options, forward_agent: true

after 'deploy:restart', 'deploy:cleanup'

namespace :deploy do
  desc 'Rolling restart'
  task :restart do
    on roles :all do
      within fetch(:current_dir) do
        execute :bundle, 'exec thin restart -C config/thin.yml'
      end
    end
  end

  desc 'Start the thin server'
  task :start do
    on roles :all do
      within fetch(:current_dir) do
        execute :bundle, 'exec thin start -C config/thin.yml'
      end
    end
  end

  desc 'Stop this server'
  task :stop do
    on roles :all do
      within fetch(:current_dir) do
        execute :bundle, 'exec thin stop -C config/thin.yml'
      end
    end
  end
end
