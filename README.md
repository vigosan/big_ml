# BigML

A Ruby wrapper for the BigML REST API

## Compile into system gems

    rake build; rake install

## Installation

Add this line to your application's Gemfile:

    gem 'big_ml'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install big_ml

## Usage

    client = BigML::Client.new(:username => 'foo', :api_key => 'bar')
    client.get_sources

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
