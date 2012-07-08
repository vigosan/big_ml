require 'spec_helper'

describe BigML::Util::Client do
  let(:keys) {
    BigML::Util::Config::VALID_OPTIONS_KEYS
  }

  context "module configuration" do
    before(:each) {
      BigML.configure do |config|
        keys.each { |key| config.send("#{key}=", key) }
      end
    }

    it "should inherit module configuration" do
      api = BigML::Util::Client.new
      keys.each { |key| api.send(key).should == key }
    end
  end

  context "class configuration" do
    let(:config) {
      {
        :username => 'user',
        :api_key  => 'secret',
        :dev_mode => true
      }
    }

    context "during initialization" do
      it "should override module configuration" do
        api = BigML::Util::Client.new(config)
        keys.each { |key| api.send(key).should == config[key] }
      end
    end

    context "after initilization" do
      before(:each) {
        BigML.configure do |config|
          keys.each { |key| config.send("#{key}=", key) }
        end
      }

      it "should override module configuration" do
        api = BigML::Util::Client.new
        config.each { |key, value| api.send("#{key}=", value) }
        keys.each { |key| api.send(key).should == config[key] }
      end
    end
  end

  context "reset module configuration" do
    let(:api) {
      BigML::Util::Client.new
    }

    before(:each) {
      BigML.reset
    }

    it "sets default username to nil" do
      api.username.should be_nil
    end

    it "sets default api key to nil" do
      api.api_key.should be_nil
    end
  end

  context "environemt mode" do
    it "uses production mode as default" do
      BigML::Util::Client.base_uri.should == BigML::Util::Config::BIGML_PROD_ENDPOINT
    end

    it "uses development when dev_mode is enabled" do
      BigML::Util::Client.new({:dev_mode => true})
      BigML::Util::Client.base_uri.should == BigML::Util::Config::BIGML_DEV_ENDPOINT
    end
  end

end
