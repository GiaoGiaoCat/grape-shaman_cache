# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape-shaman_cache/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Victor Wang"]
  gem.email         = ["wjp2013@gmail.com"]
  gem.description   = %q{HTTP and server side cache integration for Grape and Rack applications}
  gem.summary       = %q{HTTP and server side cache integration for Grape and Rack applications}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "grape-shaman_cache"
  gem.require_paths = ["lib"]
  gem.version       = Grape::ShamanCache::VERSION

  gem.add_dependency "grape", ">= 0.6.1"
  gem.add_dependency "grape-jbuilder", "0.2.0"
  gem.add_dependency "activesupport"

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
end
