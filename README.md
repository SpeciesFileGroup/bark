bark
====

[![Continuous Integration Status][6]][7]
[![Dependency Status][8]][9]

Bark is a Ruby Gem wrapper on the [Open Tree of Life API][3]. It was written over the course of the [OpenTree hackathon][2]  At present it seeks to provide a simple wrapper over all of the API calls available, returning a native json object for each response. It also acts as a sanity checker on the API calls themselves, running a suite of unit tests shared by related wrappers in [Python][5] and [R][4].

## Installation

Bark is written targetting Ruby 2.1.x.

Add this line to your application's Gemfile:

    gem 'bark'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bark

## Usage

Bark is broken down into Request and Response objects.  These are additionally wrapped with a set of helper methods that map 1:1 with the [Open Tree URLs][3].  Binding method names [follow a convention][] adopted by the related Python and R frameworks.

Very simply:

```
  require 'bark'
```

Then

```ruby
  Bark.tol_about  # => { big hash }
```

Pass parameters like so:

```ruby
  Bark.get_study(params: {:study_id => '2113'})   # => json response
```

Parameter keys can be symbols or strings.

## Documentation

Documentation is presently being autogenerate at [RubyDoc.info][1]

## Contributing

1. Fork it ( http://github.com/SpeciesFileGroup/bark/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

Bark is open source, it is available under the BSD licence.

[1]: http://rubydoc.info/github/SpeciesFileGroup/bark/frames
[2]: https://github.com/OpenTreeOfLife/hackathon  
[3]: https://github.com/OpenTreeOfLife/opentree/wiki/Open-Tree-of-Life-APIs
[4]: https://github.com/fmichonneau/rotl
[5]: https://github.com/OpenTreeOfLife/opentree-interfaces
[6]: https://secure.travis-ci.org/SpeciesFileGroup/bark.png?branch=master
[7]: http://travis-ci.org/SpeciesFileGroup/bark?branch=master
[8]: https://gemnasium.com/SpeciesFileGroup/bark.png?branch=master
[9]: https://gemnasium.com/SpeciesFileGroup/bark?branch=master
[10]: https://github.com/OpenTreeOfLife/opentree/wiki/Libraries-for-working-with-opentree-in-various-languages-%28service-bindings-and-wrappers,-etc.%29


