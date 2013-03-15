# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liftoff'

Gem::Specification.new do |gem|
  gem.name          = 'liftoff'
  gem.version       = Liftoff::VERSION
  gem.authors       = ['Mark Adams', 'Gordon Fontenot']
  gem.email         = ['mark@thoughtbot.com', 'gordon@thoughtbot.com']
  gem.description   = %q{CLI for setting up new Xcode projects.}
  gem.summary       = %q{Provides a variety of commands for automating simple Xcode settings for new projects.}
  gem.homepage      = "https://github.com/thoughtbot/liftoff"

  gem.add_dependency 'slop', '~> 3.4.4'
  gem.add_dependency 'xcodeproj', '~> 0.5.1'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
