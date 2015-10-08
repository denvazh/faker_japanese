module Faker
  # Japanese localization for Faker
  module Japanese
    # Name localization
    class Name < Base
      class << self
        # Fake first name
        # @return [Kanji]
        def first_name
          fetch(:first_name)
        end

        # Fake last name
        # @return [Kanji]
        def last_name
          fetch(:last_name)
        end

        # Fake full name
        # @return [Kanji] string combining last and first name
        def name
          first_name = fetch(:first_name)
          last_name = fetch(:last_name)
          name_kanji = "#{last_name} #{first_name}"
          name_yomi = "#{last_name.yomi} #{first_name.yomi}"
          name_kana = "#{last_name.kana} #{first_name.kana}"
          name_romaji = "#{last_name.romaji} #{first_name.romaji}"
          Kanji.new(name_kanji, name_yomi, name_kana, name_romaji)
        end
      end

      use_japanese_method Faker::Name, :first_name
      use_japanese_method Faker::Name, :last_name
      use_japanese_method Faker::Name, :name
    end
  end
end
