Capistrano::Configuration.instance.load do
  namespace :symlink do
      desc "Setup symlinks"
      task :setup, :except => { :no_release => true } do
        symlinks.each do |symlink|
          symlink_path = symlink[:path]

          dir_path = /^(.*)\/.*$/.match(symlink_path)[1]
          run "mkdir -p #{shared_path}/#{dir_path} && touch #{shared_path}/#{symlink[:path]}"
        end
      end

      desc "Upload symlink files"
      task :local_upload, :roles => :app, :except => { :no_release => true } do
        labels = ENV['LABELS'].split(',')
        symlinks.select { |symlink| labels.include? symlink[:label].to_s }.each { |symlink|
          upload symlink[:path], "#{shared_path}/#{symlink[:path]}" if File.file?(symlink[:path])
        }
      end

      desc "Download symlink files from remote"
      task :remote_download, :roles => :app, :except => { :no_release => true } do
        labels = ENV['LABELS'].split(',')
        symlinks.select { |symlink| labels.include? symlink[:label].to_s }.each { |symlink|
          download "#{shared_path}/#{symlink[:path]}", symlink[:path]
        }
      end

      desc <<-DESC
        [internal] Updates the symlinks to the just deployed release.
      DESC
      task :symlink, :roles => :app, :except => { :no_release => true } do
        symlinks.each do |symlink|
          run "ln -nfs #{shared_path}/#{symlink[:path]} #{release_path}/#{symlink[:path]}"
        end
      end
    end
end
