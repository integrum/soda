set :application, "soda"
set :repository, "git@github.com:integrum/soda.git"

set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :scm_username, 'deploy'
set :scm_password, 'it2005'
set :user, 'deploy'
set :password, 'deploy4integrum'

set :use_sudo, false

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache

# humshakal.integrumdemo.com
role :app, "soda.integrumdemo.com"
role :web, "soda.integrumdemo.com"
role :db,  "soda.integrumdemo.com", :primary => true

after "deploy:setup", "deploy:more_setup"
after "deploy:update_code", "deploy:symlink_config"
after "deploy", "deploy:cleanup"

deploy.task :more_setup, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
  run "mkdir -p #{shared_path}/config #{shared_path}/public/uploads"
  run "mongrel_rails cluster::configure -e production -a 127.0.0.1 --user deploy --group deploy -l #{shared_path}/log/mongrel.log -P #{shared_path}/log/mongrel.pid -p 8000 -c #{deploy_to}/current -C #{shared_path}/config/mongrel_cluster.yml"
end

deploy.task :symlink_config, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
  run  <<-EOC
    ln -nsf #{shared_path}/config/database.yml #{current_release}/config &&
    ln -nsf #{shared_path}/config/mongrel_cluster.yml #{current_release}/config &&
    ln -nsf #{shared_path}/public/uploads #{current_release}/public/images/uploads &&
    cd #{current_release} && RAILS_ENV=production rake db:migrate
  EOC
end

deploy.task :start do
  run "mongrel_rails cluster::start -C #{shared_path}/config/mongrel_cluster.yml"
end

deploy.task :stop do
  run "mongrel_rails cluster::stop -C #{shared_path}/config/mongrel_cluster.yml"
end

deploy.task :restart do
  stop
  start
end
