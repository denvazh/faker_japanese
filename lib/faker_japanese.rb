require 'faker'
require 'yaml'

module Faker
  module Japanese
    # Location on the disk of this script
    SELFDIR = File.expand_path(File.dirname(__FILE__))

    # Kanji string
    class Kanji < String
      attr_reader :yomi, :kana, :romaji

      # Create new Kanji string instance
      # @param [String] kanji string in kanji from
      # @param [String] yomi string with hiragana readings
      # @param [String] kana string with katakana readings
      # @param [String] romaji romanized string
      def initialize(kanji, yomi, kana, romaji)
        super(kanji)
        @yomi = yomi
        @kana = kana
        @romaji = romaji
      end
    end

    class Base
      class << self

        # Using callback to store loaded data when subclass is created
        # @param [Module] klass class name
        def inherited(klass)
          klass.class_variable_set '@@data', load_data(klass)
        end

        # Load fake data from yml file
        # @param [Module] klass class name
        def load_data(klass)
          datafile = File.join(SELFDIR, 'faker_japanese',
                               'data', "#{klass.to_s.split('::').last.downcase}.yml")
          if datafile && File.readable?(datafile)
            data = YAML.load_file(datafile).each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
            data.inject({}) do |res, item|
              key, values, = item
              res.update(key => values.map! { |v| Kanji.new(*v) })
            end
          else
            nil
          end
        end

        # Fetch random value from name dictionary
        # @param [String] key in the @@data
        # @return [Kanji]
        def fetch(key)
          val = self.class_variable_get('@@data')[key]
          val[rand(val.size)]
        end

        # Swap method if block was evaluated to true
        # @param [Module] klass name of the class
        # @param [Symbol] name method name
        def swap_method(klass, name)
          original_method =klass.method(name)
          new_method =method(name)
          klass.singleton_class.send(:define_method,
                                     name,
                                     proc { yield ? new_method.call : original_method.call })
        end

        # Decide which method to use based on value of Faker::Config.locale
        # @param [Module] klass name of the class
        # @param [Symbol] name method name
        def use_japanese_method(klass, name)
          swap_method(klass, name) do
            Faker::Config.locale == :ja
          end
        end

      end # << self
    end # Base
  end # Japanese
end # Faker

require 'faker_japanese/version'
require 'faker_japanese/name'
