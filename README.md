# Embrace

[![Gem Version][gem-badge]][gem]
[![Build status][build-badge]][build]
[![Coverage Status][coverage-badge]][coverage]

Embrace is a simple library for bracketing strings, or parts of strings. While it focuses on three common
bracketing styles, you can use custom styles, or even wrap text in arbitrary strings.

## Usage

The simplest way to use Embrace is to use its `String` refinements. Just put the following in your
file, module or class.

```ruby
require "embrace"

module MyModule
  using Embrace

  # ...
end
```

If you want Embrace's `String` methods to be available globally, then include `Embrace::StringMethods`
in an app initializer somewhere.

```ruby
require "embrace"

String.include Embrace::StringMethods
```

### Basic bracketing methods

Whether you use the refinements, or include the string methods, the following string methods will become
available:

```
"text".bracket      # => "[text]"
"text".parenthesize # => "(text)"
"text".brace        # => "{text}"
```

### Custom bracket styles

Each of the methods accepts a `style` parameter, which will be used to bracket the text. Note that the
style should include both opening and closing strings, but is otherwise entirely arbitrary. The first
half of the style will be placed before the text, and the second half will be placed after the text. If
the style is an odd length, the extra character will go after the text.

```ruby
"text".bracket(style: "<b></b>")   # => "<b>text</b>"
"text".parenthesize(style: "<-->") # => "<-text->"
"text".brace(style: "«»")          # => "«text»"
```

### Bracketing portions of text

All of the Embrace methods accept a `pattern` parameter. If supplied, then only the matching portions of
the string will be bracketed.

```ruby
"the quick brown fox.".parenthesize                       # => "(the quick brown fox.)"
"the quick brown fox.".parenthesize(pattern: /quick|fox/) # => "the (quick) brown (fox)."
```

### Wrapping text in arbitrary strings

If you need to wrap text in asymmetrical strings, then you can supply an array as the `style` parameter.

```ruby
"the quick brown fox.".bracket(style: %w{ beginning> <end }) # => "beginning>the quick brown fox.<end"
```

Note that only the first two elements of the array will be used.

### Module function

`bracket` is available as a module function in the `Embrace` module.

```ruby
Embrace.bracket("some text", style: "<i></i>") # => "<i>some text</i>"
```

### Currying

Finally, you can create a "curried" version of `Embrace.bracket`.

```ruby
wrapper = Embrace.bracketer(style: "()", pattern: "text")
[ "some text", "some more text" ].map(&wrapper) # => [ "some (text)", "some more (text)" ]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'embrace'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install embrace

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
 You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update
the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the
version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johncarney/embrace. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[gem-badge]:        https://badge.fury.io/rb/embrace.svg
[gem]:              http://badge.fury.io/rb/embrace
[build-badge]:      https://travis-ci.org/johncarney/embrace.svg?branch=master
[build]:            https://travis-ci.org/johncarney/embrace
[coverage-badge]:   https://img.shields.io/coveralls/johncarney/embrace.svg
[coverage]:         https://coveralls.io/r/johncarney/embrace?branch=master
