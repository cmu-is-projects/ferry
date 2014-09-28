# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ferry/version'

Gem::Specification.new do |spec|
  spec.name          = "ferry"
  spec.version       = Ferry::VERSION
  spec.authors       = ["Anthony Corletti", "Logan Watanabe", "Larry Heimann"]
  spec.email         = ["anthcor@gmail.com", "loganwatanabe@gmail.com", "profh@cmu.edu"]
  spec.summary       = "Ferry is a data migration and data manipulation tool"
  spec.description   = "Ferry is a data migration and data manipulation tool that seeks to simplify the increasingly prevalent big data problems that tech companies face"
  spec.homepage      = "https://github.com/cmu-is-projects/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "progressbar"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "mysql"
end
