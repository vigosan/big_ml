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
        "meta" => { :limit => 20, :next => nil, :offset => 0, :previous => nil, :total => 2 },
        "objects" => [
          { :code => 201, :credits => 0.0087890625, :file_name => "iris.csv", :name => "iris.csv" },
          { :code => 201, :credits => 0.0086361836, :file_name => "gender.csv", :name => "gender.csv" }
        ]
      }
    }

    it "request the correct resources" do
      extra_params = { :offset => 0, :limit => 20 }
      options = extra_params.merge!(auth)
      stub_request(:get, "https://bigml.io/andromeda/source").with(:query => options).
        to_return(:status => 200, :body => sources_template, :headers => {})
      client.get_sources(extra_params)
    end
  end

  describe "#get_source" do
    let(:source_template) {
      { :code => 201, :credits => 0.0087890625, :file_name => "iris.csv", :name => "iris.csv" }
    }

    it "request the correct resource" do
      stub_request(:get, "https://bigml.io/andromeda/source/id").with(:query => auth).
        to_return(:status => 200, :body => source_template, :headers => {})
      client.get_source('id')
    end
  end

  describe "#update_source" do
    it "request the correct resource" do
      new_params = { :name => 'new_name' }
      options = new_params.merge!(auth)
      stub_request(:put, "https://bigml.io/andromeda/source/id").with(:query => options).
        to_return(:status => 200, :body => "", :headers => {})
      client.update_source('id', new_params)
    end
  end

  describe "#find_sources" do
    let(:sources_template) {
      {
        "meta" => { :limit => 20, :next => nil, :offset => 0, :previous => nil, :total => 1 },
        "objects" => [
          { :code => 201, :credits => 0.0087890625, :file_name => "iris.csv", :name => "iris.csv" }
        ]
      }
    }

    it "request the correct resources" do
      search_params = { :name => 'iris.csv', :size__gt => 1048576 }
      stub_request(:get, "https://bigml.io/andromeda/source").with(:query => auth.merge(search_params)).
        to_return(:status => 200, :body => sources_template, :headers => {})
      client.find_sources(search_params)
    end
  end

  describe "#delete_source" do
    it "request the correct resources" do
      stub_request(:delete, "https://bigml.io/andromeda/source/id").with(:query => auth).
        to_return(:status => 200, :body => "", :headers => {})
      client.delete_source('id')
    end
  end
end
