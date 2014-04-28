require 'spec_helper'

describe Faker::Japanese do

  it "should use native methods when locale is not set to ja" do
    if (Faker::Config.locale != 'ja')
      name = Faker::Name.name
      name.should_not be_nil
      name.contains_cjk?.should == false
      first_name = Faker::Name.first_name
      first_name.should_not be_nil
      first_name.contains_cjk?.should == false
      last_name = Faker::Name.first_name
      last_name.should_not be_nil
      last_name.contains_cjk?.should == false
    else
      fail
    end
  end

  it "should not use japanese method when locale is not set to ja" do
    name = Faker::Name.name
    expect { name.yomi }.to raise_error NoMethodError
    expect { name.kana }.to raise_error NoMethodError
    expect { name.romaji }.to raise_error NoMethodError
  end

  it "should use japanese method when locale is set to ja" do
    Faker::Config.locale = 'ja'
    if (Faker::Config.locale == 'ja')
      first_name = Faker::Name.first_name
      first_name.should_not be_nil
      first_name.contains_cjk?.should == true
      last_name = Faker::Name.last_name
      last_name.should_not be_nil
      last_name.contains_cjk?.should == true
      name = Faker::Name.name
      name.should_not be_nil
      name.contains_cjk?.should == true
      name.yomi.contains_cjk?.should == true
      name.kana.contains_cjk?.should == true
      name.romaji.contains_cjk?.should == false
    else
      fail
    end
  end

end
