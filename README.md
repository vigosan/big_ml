# BigML

A Ruby wrapper for the [BigML REST API](https://bigml.com/developers), provides access to sources, datasets, models, and predictions. You can create, retrieve, update and delete

[![Build Status](https://secure.travis-ci.org/vigosan/big_ml.png?branch=master)](http://travis-ci.org/vigosan/big_ml)

## Synopsis

```ruby
require 'rubygems'
require 'big_ml'

BigML.configure do |c|
  c.username = 'foo'
  c.api_key  = 'bar'
  c.dev_mode = true
  #c.debug   = true # Raises errors for bad requests
end

# easy creation of sources
file_path = "fixtures/iris.csv"
source = BigML::Source.create(file_path)

# Are you looking for old dataset?
all_datasets = BigML::Dataset.all

# or just want to create one?
dataset = source.to_dataset

# find a concrete one
model = BigML::Model.find("4fe8868a035d07682f002891")

# create you predictions using parameters...
prediction = BigML::Prediction.create(model.resource, { :input_data => { "000001" => 3 }})
prediction.destroy

# you can destroy everything!
BigML::Model.delete("4fe8868a035d07682f002891")

```

## Installation

### Bundler

Add this line to your application's Gemfile:

    source 'https://rubygems.org'
    gem 'big_ml'

And then install the new dependencies with:

    $ bundle install

### Rubygems

Install the gem with rubygem in your system:

    $ gem install big_ml

### Dependencies

- httparty


## Ruby Interpreter Compatibility

This library has been tested on the following ruby interpreters:

* 1.9.3
* 2.1.0

## Running the tests

Download and run the test suit:

    $ git clone git@github.com:vigosan/big_ml.git
    $ cd big_ml
    $ bundle install
    $ rspec spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
