require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new
task :test => :spec

# Testing with rspec
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = %w(--color --format documentation)
end
task test: :spec

# Documentation
desc "Generate gem documentation (same as running 'rake yard')"
YARD::Rake::YardocTask.new do |t|
  t.files = %w(lib/**/*.rb)
  t.stats_options = %w(--list-undoc --compact)
end
task doc: :yard

# Default Rake task
task default: :spec
