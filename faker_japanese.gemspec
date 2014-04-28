# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faker_japanese/version'

Gem::Specification.new do |spec|
  spec.name          = "faker_japanese"
  spec.version       = Faker::Japanese::VERSION
  spec.authors       = ["Denis Vazhenin"]
  spec.email         = ["denis.vazhenin@me.com"]
  spec.description   = %q{Faker extension providing japanese names}
  spec.summary       = %q{Faker extension for japanese names}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faker"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
	spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "fuubar"
	spec.add_development_dependency "yard"
end
