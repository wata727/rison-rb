# rison-rb
[![Build Status](https://github.com/wata727/rison-rb/workflows/build/badge.svg?branch=master)](https://github.com/wata727/rison-rb/actions)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.txt)
[![Gem Version](https://badge.fury.io/rb/rison-rb.svg)](https://badge.fury.io/rb/rison-rb)

A Ruby implementation for [Rison - Compact Data in URIs](https://rison.io).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rison-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rison-rb

## Usage

This is a Ruby implementation for Rison that represents compact data in URIs. This module provides a parsing and dumping API like JSON module:

```ruby
require "rison"

Rison.dump({ a: 1, b: true , c: ['foo', 'bar'] }) # => (a:1,b:!t,c:!(foo,bar))
Rison.parse('(a:1,b:!t,c:!(foo,bar))') # => { 'a' => 1, 'b' => true , 'c' => ['foo', 'bar'] }
```

### Symbolize names

Parsing generates a hash key as a string, just like JSON module. But you can also switch keys to symbols with the `symbolize_names` option:

```ruby
Rison.parse('(a:!(foo,bar,(b:1)))', symbolize_names: true) # => { a: ['foo', 'bar', { b: 1 }] }
```

### O-Rison and A-Rison

Similarly, O-Rison and A-Rison variations are supported:

```ruby
# O-Rison
Rison.dump({ a: 1, b: 2 }, mode: :object) # => a:1,b:2
Rison.parse('a:1,b:2', mode: :object) # => { 'a' => 1, 'b' => 2 }

# A-Rison
Rison.dump(['foo', 'bar'], mode: :array) # => foo,bar
Rison.parse('foo,bar', mode: :array) # => ['foo', 'bar']
```

### Differences from the original syntax

[The original syntax](https://rison.io) defines only alphanumeric and `-_./~` as ASCII characters for idchar. But [rison.js](https://github.com/Nanonid/rison) accepts other ASCII characters as idchar.

rison-rb conforms to the rison.js implementation. Therefore, it differs from the original syntax in the following points:

- It accepts ASCII characters other than `<space>'!:(),*@$` and all non-ASCII characters as idchar.
- Numbers starting with 0 are allowed.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wata727/rison-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the rison-rb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/wata727/rison-rb/blob/master/CODE_OF_CONDUCT.md).
