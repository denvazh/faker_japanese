require 'faker'

module Faker
	module Japanese
		SELFDIR = File.expand_path(File.dirname(__FILE__))

		class Base
			class << self

				# Using callback to store loaded data when subclass is created
				def inherited(klass)
					klass.class_variable_set "@@data", load_data(klass)
				end

				def load_data(klass)
					datafile = File.join(SELFDIR, 'faker_japanese',
						'data', "#{klass.to_s.split('::').last.downcase}.yml")
					if datafile && File.readable?(datafile)
					else
						nil
					end
					#puts "This is class: #{klass}"
				end

				# Dynamically replace method of given class at runtime if condition is met
				def swap_method(klass, name, condition=true)
					original_method 	=klass.method(name)
					new_method				=method(name)
					klass.singleton_class.send :define_method, name, proc {
						condition ? new_method.call : original_method.call
					}
				end

				# Decide which method to use based on value of Faker::Config.locale
				def use_japanese_method(klass, name)
					swap_method(klass, name, Faker::Config.locale == "ja")
				end

			end # << self
		end # Base
	end # Japanese
end # Faker

require 'faker_japanese/version'
require 'faker_japanese/name'
