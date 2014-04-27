module Faker
  module Japanese
    class Name < Base
      class << self
        def last_name
          puts "Reserved for last_name"
        end

        def first_name
          puts "Reserved for first_name"
        end
      end

      use_japanese_method Faker::Name, :first_name
      use_japanese_method Faker::Name, :last_name

    end
  end
end
