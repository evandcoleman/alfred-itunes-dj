# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmapparser/version'

Gem::Specification.new do |spec|
  spec.name          = 'dmapparser'
  spec.version       = DMAPParser::VERSION
  spec.authors       = ['Jurriaan Pruis']
  spec.email         = ['email@jurriaanpruis.nl']
  spec.summary       = 'Parses DMAP data'
  spec.homepage      = 'https://github.com/jurriaan/dmapparser'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::RUBY

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']
  spec.extra_rdoc_files = ['README.md', 'LICENSE']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rake'

  spec.required_ruby_version = '>= 2.0.0'
end
