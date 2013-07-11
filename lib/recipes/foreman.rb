Capistrano::Configuration.instance.load do
  namespace :foreman do
    desc "Export the Procfile to Ubuntu's upstart scripts"
    task :export, :roles => :app do
      run "cd #{current_path} && bundle exec foreman export upstart $HOME/.init -f ./Procfile -a #{application} -u #{user} -l #{shared_path}/log"
    end

    desc "Start the application services"
    task :start, :roles => :app do
      sudo "start #{application}"
    end

    desc "Stop the application services"
    task :stop, :roles => :app do
      sudo "stop #{application}"
    end

    desc "Restart the application services"
    task :restart, :roles => :app do
      run "sudo start #{application} || sudo restart #{application}"
    end

    desc "Display logs for a certain process - arg example: PROCESS=web-1"
    task :logs, :roles => :app do
      run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
    end
  end
end