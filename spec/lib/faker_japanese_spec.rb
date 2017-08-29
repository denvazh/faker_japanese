require 'spec_helper'

describe Faker::Japanese do
  context 'when locale is NOT set to :ja' do
    before(:all) { Faker::Config.locale = :en }
    after(:all) { Faker::Config.locale = :en }

    it 'uses default locale' do
      expect(Faker::Config.locale).to eq(:en)
      expect(Faker::Config.locale).not_to eq(:ja)
    end

    describe Faker::Name, 'use original methods' do
      it '#name' do
        name = Faker::Name.name
        expect(name).not_to be_nil
        expect(name.ascii_only?).to be_truthy
        expect(name.contains_cjk?).to be_falsey
        expect { name.yomi }.to raise_error NoMethodError
        expect { name.kana }.to raise_error NoMethodError
        expect { name.romaji }.to raise_error NoMethodError
      end

      it '#first_name' do
        first_name = Faker::Name.first_name
        expect(first_name).not_to be_nil
        expect(first_name.ascii_only?).to be_truthy
        expect(first_name.contains_cjk?).to be_falsey
      end

      it '#last_name' do
        last_name = Faker::Name.last_name
        expect(last_name).not_to be_nil
        expect(last_name.ascii_only?).to be_truthy
        expect(last_name.contains_cjk?).to be_falsey
      end
    end
  end

  context 'when locale is set to ja' do
    before(:all) { Faker::Config.locale = :ja }
    after(:all) { Faker::Config.locale = :en }

    it 'uses japanese locale :ja' do
      expect(Faker::Config.locale).to eq(:ja)
      expect(Faker::Config.locale).to_not eq(:en)
    end

    describe Faker::Name, 'use japanese specific methods' do
      it '#name' do
        name = Faker::Name.name
        expect(name).not_to be_nil
        expect(name.ascii_only?).to be_falsey
        expect(name.contains_cjk?).to be_truthy
        %i[yomi kana romaji].each { |method| expect(name.respond_to?(method)).to be_truthy }
        expect(name.yomi.contains_cjk?).to be_truthy
        expect(name.kana.contains_cjk?).to be_truthy
        expect(name.romaji.contains_cjk?).to be_falsey
      end

      it '#first_name' do
        first_name = Faker::Name.first_name
        expect(first_name).not_to be_nil
        expect(first_name.ascii_only?).to be_falsey
        expect(first_name.contains_cjk?).to be_truthy
      end

      it '#last_name' do
        last_name = Faker::Name.last_name
        expect(last_name).not_to be_nil
        expect(last_name.ascii_only?).to be_falsey
        expect(last_name.contains_cjk?).to be_truthy
      end
    end
  end
end
