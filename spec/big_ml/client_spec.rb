require 'helper'

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
    let(:configuration) {
      {
        :username => 'alfred',
        :api_key  => '79138a622755a2383660347f895444b1eb927730',
      }
    }

    context "during initialization" do
      it "should override module configuration" do
        api = BigML::Client.new(configuration)
        keys.each { |key| api.send(key).should == configuration[key] }
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
        configuration.each { |key, value| api.send("#{key}=", value) }
        keys.each { |key| api.send(key).should == configuration[key] }
      end
    end
  end
end
