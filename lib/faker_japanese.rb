require 'faker'

module Faker
	module Japanese
		SELFDIR = File.expand_path(File.dirname(__FILE__))

		class Kanji < String
			attr_reader :yomi, :kana, :romaji

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
				def inherited(klass)
					klass.class_variable_set "@@data", load_data(klass)
				end

				# Load fake data from yml file
				def load_data(klass)
					datafile = File.join(SELFDIR, 'faker_japanese',
						'data', "#{klass.to_s.split('::').last.downcase}.yml")
					if datafile && File.readable?(datafile)
            data = YAML.load_file(datafile).each_with_object({}){|(k,v), h| h[k.to_sym] = v}
            data.inject({}) do |res, item|
            	key, values, = item
            	res.update(key => values.map! { |v| Kanji.new(*v) })
            end
					else
						nil
					end
				end

				# Search
				def fetch(key)
					val = self.class_variable_get("@@data")[key]
					ret = val[rand(val.size)]
				end

				# Swap method if block was evaluated to true
				def swap_method(klass, name)
					original_method 	=klass.method(name)
					new_method				=method(name)
					klass.singleton_class.send :define_method, name, proc {
						yield ? new_method.call : original_method.call
					}
				end

				# Decide which method to use based on value of Faker::Config.locale
				def use_japanese_method(klass, name)
					swap_method(klass, name) do
						Faker::Config.locale == "ja"
					end
				end

			end # << self
		end # Base
	end # Japanese
end # Faker

require 'faker_japanese/version'
require 'faker_japanese/name'
