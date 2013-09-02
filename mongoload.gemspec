# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoload"

Gem::Specification.new do |s|
  s.name        = "mongoload"
  s.license     = "MIT"
  s.authors     = ["PJ Gray"]
  s.email       = "pj@pj4533.com"
  s.homepage    = "http://www.saygoodnight.com/"
  s.version     = Mongoload::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "mongoload"
  s.description = "A command script for loading data into MongoDB"

  s.add_dependency "commander", "~> 4.1.2"
  s.add_dependency "terminal-table", "~> 1.4.5"
  s.add_dependency "term-ansicolor", "~> 1.0.7"
  s.add_dependency "mysql2"
  s.add_dependency "mongo"
  s.add_dependency "bson_ext"
  s.add_dependency "bson"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
