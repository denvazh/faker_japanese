require 'faker_japanese'

class String
  # Method to check if string contains cjk characters
  def contains_cjk?
    !!(self =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/)
  end
end

I18n.enforce_available_locales = true

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
end
