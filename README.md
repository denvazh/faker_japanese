# faker_japanese

Faker extension to generate japanese names.
Provides fake first and last name in kanji,
hiragana, katakana and romaji(name written
with latin alphabet).

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

Before using, set locale to `ja`

```
Faker::Config.locale = "ja"
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

Currently, using only methods and localizaion provide by Faker
it is not possible to reuse they values to generate other `fake` data.

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

On the other hand, using `faker_japanese` it is possible to pass
name in romaji to generate valid value:

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
