require 'capistrano'
require 'capistrano/cli'
require "capistrano-rbenv"
require "bundler/capistrano"
require "whenever/capistrano"
require "delayed/recipes"
require "capistrano/ext/multistage"
require "dotenv/capistrano"

Dir.glob(File.join(File.dirname(__FILE__), '/recipes/*.rb')).sort.each { |f| load f }
