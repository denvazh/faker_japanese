require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new
task :default => :spec
task :test => :spec

# Documentation
YARD::Rake::YardocTask.new do |t|
	t.files   = ['lib/**/*.rb']   # optional
end

# desc "Generate gem documentation (same as running 'rake yard')"
task :doc => :yard
