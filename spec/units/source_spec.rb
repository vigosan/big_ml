require "spec_helper"

describe BigML::Source do
  describe "#code" do
    it "return code when set" do
      source = BigML::Source.new('code' => 201)
      source.code.should == 201
    end

    it "return nil when not set" do
      source = BigML::Source.new('code' => nil)
      source.code.should be_nil
    end

    it "extract source id from resource" do
      source = BigML::Source.new('resource' => 'souce/4f66a0b903ce8940c5000000')
      source.id.should == "4f66a0b903ce8940c5000000"
    end
  end
end
