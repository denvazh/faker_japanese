require 'faker_japanese'

require 'pry'

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
