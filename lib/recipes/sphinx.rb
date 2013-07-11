Capistrano::Configuration.instance.load do
  namespace :sphinx do
    desc "Symlink Sphinx indexes"
    task :symlink_indexes, :roles => [:app] do
      run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
    end
  end
end

