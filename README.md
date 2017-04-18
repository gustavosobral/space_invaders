# SpaceInvaders

[![Build Status](https://travis-ci.org/gustavosobral/space_invaders.svg?branch=master)](https://travis-ci.org/gustavosobral/space_invaders) [![Coverage Status](https://coveralls.io/repos/github/gustavosobral/space_invaders/badge.svg?branch=master)](https://coveralls.io/github/gustavosobral/space_invaders?branch=master) [![Code Climate](https://codeclimate.com/github/gustavosobral/space_invaders/badges/gpa.svg)](https://codeclimate.com/github/gustavosobral/space_invaders) [![Issue Count](https://codeclimate.com/github/gustavosobral/space_invaders/badges/issue_count.svg)](https://codeclimate.com/github/gustavosobral/space_invaders)

This is the SpaceInvaders detector gem! It aims to detect space invaders on radar images, even with noise on them. 

You can check on `spec/fixtures` folder to see valid files from space invaders, radar image and application result.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'space_invaders'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install space_invaders

## Usage

You can use the application programmatically by installing the gem and using on the Ruby environment (You can run `bin/console` for this). Check the examples folder for more examples.

```ruby
SpaceInvaders::Core::Analyzer.new(invaders: 'spec/fixtures/space_invaders',
                                  radar: 'spec/fixtures/radar_image',
                                  algorithm_name: :scan).analyze
```

There is also a CLI provided that can be used.

### CLI

The application also has a CLI built-in that can be used directly on any *nix terminal. 

```
$ space-invaders analyze spec/fixtures/space_invaders spec/fixtures/radar_image
$ space-invaders analyze spec/fixtures/space_invaders spec/fixtures/radar_image -a=scan -t=0.85
$ space-invaders analyze spec/fixtures/space_invaders spec/fixtures/radar_image --output=output
```

Use the help command for more information.

```
$ space-invaders help analyze
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gustavosobral/space_invaders.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

