# Common hooks for all scenarios.
Capistrano::Configuration.instance.load do
  #before 'deploy:update_code', 'thinking_sphinx:stop'

  after "deploy:update_code", "deploy:migrate"
  #after 'deploy:update_code', 'thinking_sphinx:start'

  #after 'deploy:finalize_update', 'sphinx:symlink_indexes'

  after "deploy:setup",           "symlink:setup"
  after "deploy:finalize_update", "symlink:symlink"

  after "deploy:start",           "unicorn:start"
  #after "deploy:start",           "delayed_job:start"

  after "deploy:stop",            "unicorn:stop"
  #after "deploy:stop",            "delayed_job:stop"

  after "deploy:restart",         "unicorn:restart"
  #after "deploy:restart",         "delayed_job:restart"

  after "deploy:restart",         "deploy:cleanup"
end


