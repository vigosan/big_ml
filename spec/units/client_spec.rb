require 'spec_helper'

describe BigML::Util::Client do
  let(:keys) { BigML::Util::Config::VALID_OPTIONS_KEYS }

  context "module configuration" do
    before do
      BigML.configure do |config|
        keys.each { |key| config.send("#{key}=", key) }
      end
    end

    it "should inherit module configuration" do
      api = BigML::Util::Client.new
      keys.each { |key| expect(api.send(key)).to eq(key) }
    end
  end

  context "class configuration" do
    let(:config) do
      {
        username: 'user',
        api_key: 'secret',
        dev_mode: true
      }
    end

    context "during initialization" do
      it "should override module configuration" do
        api = BigML::Util::Client.new(config)
        keys.each { |key| expect(api.send(key)).to eq(config[key]) }
      end
    end

    context "after initilization" do
      before do
        BigML.configure do |config|
          keys.each { |key| config.send("#{key}=", key) }
        end
      end

      it "should override module configuration" do
        api = BigML::Util::Client.new
        config.each { |key, value| api.send("#{key}=", value) }
        keys.each { |key| expect(api.send(key)).to eq(config[key]) }
      end
    end
  end

  context "reset module configuration" do
    let(:api) { BigML::Util::Client.new }

    before do
      BigML.reset
    end

    it "sets default username to nil" do
      expect(api.username).to be_nil
    end

    it "sets default api key to nil" do
      expect(api.api_key).to be_nil
    end
  end

  context "environment mode" do
    it "uses production mode as default" do
      expect(BigML::Util::Client.base_uri).to eq(BigML::Util::Config::BIGML_PROD_ENDPOINT)
    end

    it "uses development when dev_mode is enabled" do
      BigML::Util::Client.new({ dev_mode: true })
      expect(BigML::Util::Client.base_uri).to eq(BigML::Util::Config::BIGML_DEV_ENDPOINT)
    end
  end
end
