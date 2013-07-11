# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "capistrano-recipes"
  s.version     = CapistranoRecipes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Phil Misiowiec", "Leonardo Bighetti"]
  s.email       = ["github@webficient.com"]
  s.homepage    = ""
  s.summary     = %q{Capistrano recipes}
  s.description = %q{Fork of capistrano-recipes https://github.com/webficient/capistrano-recipes}

  s.required_rubygems_version = ">= 1.3.6"
  # s.rubyforge_project = "capistrano-recipes"

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]

  s.add_dependency "capistrano", ">= 2.5.9"
  s.add_dependency "capistrano-ext", ">= 1.2.1"
  s.add_dependency "capistrano-rbenv", ">= 1.0.0"
  s.add_dependency "dotenv-rails"
end