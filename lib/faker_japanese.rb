require 'faker'
require 'yaml'
require 'pathname'

# Faker
module Faker
  # Japanese localization for Faker
  module Japanese
    # Working directory where this script is located
    WORKDIR = Pathname.new(::File.expand_path(::File.dirname(__FILE__)))

    # Kanji string
    class Kanji < String
      # @return [String] hiragana form
      attr_reader :yomi
      # @return [String] katakana form
      attr_reader :kana
      # @return [String] romanized form
      attr_reader :romaji

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

    # Faker Base class
    class Base
      class << self
        # Use callback to store loaded data when subclass is created
        # @param [Class] klass class name
        def inherited(klass)
          raise("#{klass} should be Class") unless klass.is_a?(Class)
          klass.class_variable_set '@@data', load_data(klass)
        end

        # Convert full class name to the lower case string with class name only
        # @param [Class] klass class name
        # @return [String]
        def demodulize(klass)
          klass.to_s.split('::').last.downcase
        end

        # Load yml file with minor pre-processing
        # @param [String] filepath full path to the file
        # @return [Hash]
        def load_raw_yaml(filepath)
          return nil unless filepath && ::File.readable?(filepath)
          YAML.load_file(filepath).each_with_object({}) do |(k, v), h|
            h[k.to_sym] = v
          end
        end

        # Created dictionary with loaded data
        # @param [Module] klass class name
        def load_data(klass)
          datafile = "#{demodulize(klass)}.yml"
          data = load_raw_yaml(WORKDIR.join('faker_japanese', 'data', datafile))
          return data if data.nil?
          data.inject({}) do |res, item|
            key, values = item
            res.update(key => values.map! { |v| Kanji.new(*v) })
          end
          data
        end

        # Fetch random value from the name dictionary
        # @param [String] key in the @@data
        # @return [Kanji]
        def fetch(key)
          val = class_variable_get('@@data')[key]
          val[rand(val.size)]
        end

        # Swap methods if block was evaluated to true
        # @param [Class] klass name of the class
        # @param [Symbol] name method name
        def swap_method(klass, name)
          original_method = klass.method(name)
          new_method = method(name)
          proc = proc { yield ? new_method.call : original_method.call }
          klass.singleton_class.send(:define_method, name, proc)
        end

        # Decide which method to use based on value of Faker::Config.locale
        # @param [Class] klass name of the class
        # @param [Symbol] name method name
        def use_japanese_method(klass, name)
          swap_method(klass, name) { Faker::Config.locale == :ja }
        end
      end # << self
    end # Base
  end # Japanese
end # Faker

require 'faker_japanese/version'
require 'faker_japanese/name'
