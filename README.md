# BigML

A Ruby wrapper for the [BigML REST API](https://bigml.com/developers)

## Compile into system gems

    rake build; rake install

## Installation

Add this line to your application's Gemfile:

    gem 'big_ml'

And then execute:

    $ bundle

## Usage

```ruby
require 'big_ml'

BigML.configure do |c|
  c.username = 'foo'
  c.api_key = 'bar'
end

source = BigML::Source.create("spec/fixtures/iris.csv")
dataset = BigML::Dataset.create(source.resource)
model = BigML::Model.create(dataset.resource)
prediction = BigML::Prediction.create(model.resource, { :input_data => { "000001" => 3 }})
```

## Ruby Interpreter Compatibility
This library has been tested on the following ruby interpreters:

* MRI 1.9.2
* MRI 1.9.3

[![Build Status](https://secure.travis-ci.org/vigosan/big_ml.png?branch=master)](http://travis-ci.org/vigosan/big_ml)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
