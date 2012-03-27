require 'spec_helper'

describe BigML::Client do
  let(:auth) {
    { :api_key => 'secret', :username => 'user' }
  }

  let(:client) {
    BigML::Client.new(:username => 'user', :api_key => 'secret')
  }

  describe "#get_sources" do
    let(:sources_template) {
      {
        "meta" => { :limit => 20, :next => 'next', :offset => 0, :previous => nil, :total => 54 },
        "objects" => [
          { :code => 201, :credits => 0.0087890625, :file_name => "iris.csv", :name => "iris.csv" },
          { :code => 201, :credits => 0.0086361836, :file_name => "gender.csv", :name => "gender.csv" }
        ]
      }
    }

    it "request the correct resources" do
      extra_params = { :offset => 0, :limit => 20 }
      stub_request(:get, "https://bigml.io/andromeda/source").with(:query => auth.merge(extra_params)).
        to_return(:status => 200, :body => sources_template, :headers => {})
      client.get_sources(extra_params)
    end
  end

  describe "#get_source" do
    it "request the correct resource" do
      stub_request(:get, "https://bigml.io/andromeda/source/id").with(:query => auth).
        to_return(:status => 200, :body => "", :headers => {})
      client.get_source('id')
    end
  end

  describe "#update_source" do
    it "request the correct resource" do
      new_params = { :name => 'new_name' }
      stub_request(:post, "https://bigml.io/andromeda/source/id").with(:query => auth.merge(new_params)).
        to_return(:status => 200, :body => "", :headers => {})
      client.update_source('id', new_params)
    end
  end
end
