require 'spec_helper'

describe BigML::Client do
  let(:keys) {
    BigML::Config::VALID_OPTIONS_KEYS
  }

  context "module configuration" do
    before(:each) {
      BigML.configure do |config|
        keys.each { |key| config.send("#{key}=", key) }
      end
    }

    it "should inherit module configuration" do
      api = BigML::Client.new
      keys.each { |key| api.send(key).should == key }
    end
  end

  context "class configuration" do
    let(:credentials) {
      {
        :username => 'user',
        :api_key  => 'secret'
      }
    }

    context "during initialization" do
      it "should override module configuration" do
        api = BigML::Client.new(credentials)
        keys.each { |key| api.send(key).should == credentials[key] }
      end
    end

    context "after initilization" do
      before(:each) {
        BigML.configure do |config|
          keys.each { |key| config.send("#{key}=", key) }
        end
      }

      it "should override module configuration" do
        api = BigML::Client.new
        credentials.each { |key, value| api.send("#{key}=", value) }
        keys.each { |key| api.send(key).should == credentials[key] }
      end
    end
  end
end
