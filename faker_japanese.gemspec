# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faker_japanese/version'

Gem::Specification.new do |spec|
  spec.name = 'faker_japanese'
  spec.version = Faker::Japanese::VERSION
  spec.authors = ['Denis Vazhenin']
  spec.email = ['denis.vazhenin@me.com']
  spec.description = %q{Faker extension providing japanese names}
  spec.summary = %q{Faker extension for japanese names}
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'rspec-expectations', '~> 3.2.0'
  spec.add_development_dependency 'rspec-mocks', '~> 3.2.1'
  spec.add_development_dependency 'awesome_print', '~> 1.6.1'
  spec.add_development_dependency 'looksee', '~> 3.1.0'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'yard', '~> 0.8.7.6'
  spec.add_development_dependency 'fuubar'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'

  spec.add_runtime_dependency 'faker'
end
