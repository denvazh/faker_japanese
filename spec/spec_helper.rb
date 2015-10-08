# Coverage and Coveralls
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start do
  # disable coverage tracking
  add_filter 'spec' # rspec tests
end

# Use Coveralls formatter only in CI environment
if ENV['CI'].eql?('true') || ENV['TRAVIS'].eql?('true') || ENV['COVERALLS_REPO_TOKEN']
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'faker_japanese'

class String
  # Method to check if string contains cjk characters
  def contains_cjk?
    !!(self =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/)
  end
end

I18n.enforce_available_locales = true

RSpec.configure do |config|
  config.color = true
  config.failure_color = :magenta
  config.tty = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# For debugging
require 'pry'
