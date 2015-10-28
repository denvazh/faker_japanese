# faker_japanese

[![Build Status](https://travis-ci.org/denvazh/faker_japanese.svg?branch=master)](https://travis-ci.org/denvazh/faker_japanese)
[![Coverage Status](https://coveralls.io/repos/denvazh/faker_japanese/badge.svg?branch=master&service=github)](https://coveralls.io/github/denvazh/faker_japanese?branch=master)
[![Inline docs](http://inch-ci.org/github/denvazh/faker_japanese.svg?branch=master)](http://inch-ci.org/github/denvazh/faker_japanese)

Faker extension to generate Japanese names.
Provides fake first and last names in kanji, hiragana, katakana and romaji (name written with latin alphabet).
It has now around 1500 last names and around 260 first names for both genders.

## Installation

Add this line to your application's Gemfile:

    gem 'faker_japanese'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faker_japanese

## Usage

To enable faker_japanese manually use

```
require 'faker/japanese'
```

Before using, set locale to `:ja`

```
Faker::Config.locale = :ja
```

Then use `Faker::Name` as you would normally do

```
n = Faker::Name.name
=> "吉田 順"
```

```
ln = Faker::Name.last_name
=> "山本"
```

```
fn = Faker::Name.first_name
=> "吉"
```

Along with name in kanji it is possible to get
same values in hiragana, katakana and romaji

```
n.yomi
=> "よしだ じゅん"
n.kana
=> "ヨシダ ジュン"
n.romaji
=> "Yoshida Jun"

ln.yomi
=> "やまもと"
ln.kana
=> "ヤマモト"
ln.romaji
=> "Yamamoto"

fn.yomi
=> "よし"
fn.kana
=> "ヨシ"
fn.romaji
=> "Yoshi"
```

## When is it useful?

Currently, using default methods provided by Faker it is not possible to reuse localized names and 
generate from them other `fake` data.

For example

```
Faker::Config.locale = "ja"
ln = Faker::Name.last_name
p ln
=> "伊藤"
ml = Faker::Internet.email(ln)
p ml
=>"@.name"
```

On the other hand, with `faker_japanese` it is possible to pass name in romaji to generate valid value:

```
nickname = Faker::Name.name.romaji.split.join.downcase
=> "hayashiyori"
freeemail = Faker::Internet.free_email(nickname)
=> "hayashiyori@gmail.com"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgements

This small piece of code was heavily inspired by the following projects:
- [Faker main project](https://github.com/stympy/faker)
- [faker-ja by xiaotuanzi](https://github.com/xiaotuanzi/faker-ja)
- [ruby-faker-japanese by tily](https://github.com/tily/ruby-faker-japanese)
- for bulk conversion of kanji names I used [natto gem](https://bitbucket.org/buruzaemon/natto/src)

## License

MIT License (see LICENSE.txt)
