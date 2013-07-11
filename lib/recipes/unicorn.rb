Capistrano::Configuration.instance.load do

  # Unicorn config
  set :unicorn_binary, "unicorn"
  #set :unicorn_config, defer { "#{current_path}/config/unicorn/#{stage}.rb" }
  set :unicorn_config, defer { "#{current_path}/config/unicorn.rb" }
  set :unicorn_pid, defer { "#{deploy_to}/shared/pids/unicorn.pid" }

  namespace :unicorn do
    task :start, :roles => :app, :except => { :no_release => true } do
      run "cd #{current_path} && #{try_sudo} #{bundle_binary} exec #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
    end
    task :stop, :roles => :app, :except => { :no_release => true } do
      run "if [ -e #{unicorn_pid} ]; then #{try_sudo} kill `cat #{unicorn_pid}`; else echo '#{unicorn_pid} does not exists'; fi"
    end
    task :graceful_stop, :roles => :app, :except => { :no_release => true } do
      run "if [ -e #{unicorn_pid} ]; then #{try_sudo} kill -s QUIT `cat #{unicorn_pid}`; else echo '#{unicorn_pid} does not exists'; fi"
    end
    task :reload, :roles => :app, :except => { :no_release => true } do
      run "if [ -e #{unicorn_pid} ]; then #{try_sudo} kill -s USR2 `cat #{unicorn_pid}`; else echo '#{unicorn_pid} does not exists'; fi"
    end
    task :restart, :roles => :app, :except => { :no_release => true } do
      stop
      start
    end
  end
end
