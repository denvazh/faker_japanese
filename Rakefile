require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'

RSpec::Core::RakeTask.new
task :test => :spec

# Testing with rspec
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = %w(--color --format documentation)
end
task test: :spec

# Use RuboCop to check for code/style offenses
desc 'Run RuboCop to validate/lint code'
RuboCop::RakeTask.new(:rubocop) do |task|
  # don't abort rake on failure
  task.fail_on_error = false
end


# Documentation
desc "Generate gem documentation (same as running 'rake yard')"
YARD::Rake::YardocTask.new do |t|
  t.files = %w(lib/**/*.rb)
  t.stats_options = %w(--list-undoc --compact)
end
task doc: :yard

# Default Rake task
task default: [:rubocop, :spec]
