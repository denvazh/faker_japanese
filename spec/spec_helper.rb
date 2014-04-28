require 'faker_japanese'

class String
  def contains_cjk?
    !!(self =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/)
  end
end

I18n.enforce_available_locales = true

RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
end
