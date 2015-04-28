set :application, 'twitter'
set :repo_url, 'git@github.com:vigneshprakasam33/twitter_follow.git'

set :deploy_to, '/apps/twitter'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'cd /apps/twitter/current; RAILS_ENV=production bundle exec rake assets:precompile'
      execute '/etc/init.d/unicorn_twitter stop'
      execute 'sleep 5'
      execute '/etc/init.d/unicorn_twitter start'
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end