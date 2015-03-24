# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ferry/version'

Gem::Specification.new do |spec|
  spec.name          = "ferry"
  spec.version       = Ferry::VERSION
  spec.authors       = ["Anthony Corletti", "Logan Watanabe", "Larry Heimann"]
  spec.email         = ["anthcor@gmail.com", "loganwatanabe@gmail.com", "profh@cmu.edu"]
  spec.summary       = "Ferry is a data migration and visualization command line tool rubygem"
  spec.description   = "Ferry is a data migration and visualization command line tool rubygem that seeks to simplify the increasingly prevalent big data problems for developers"
  spec.homepage      = "https://cmu-is-projects.github.io/ferry"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "activerecord", "~> 4.1.7"
  spec.add_development_dependency "arel"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "json"
  spec.add_development_dependency "minitest", "~> 5.4.1"
  spec.add_development_dependency "mysql2", "~> 0.3.16"
  spec.add_development_dependency "pg", "~> 0.17.1"
  spec.add_development_dependency "rake", "~> 10.3.2"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "sqlite3", "~> 1.3.10"
  spec.add_runtime_dependency "progressbar", "~> 0.21.0"
  spec.add_runtime_dependency "highline", "~> 1.6.21"
end
