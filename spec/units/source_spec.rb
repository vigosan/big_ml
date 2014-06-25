require "spec_helper"

describe BigML::Source do
  describe "#code" do
    it "return code when set" do
      source = BigML::Source.new('code' => 201)
      expect(source.code).to eq(201)
    end

    it "return nil when not set" do
      source = BigML::Source.new('code' => nil)
      expect(source.code).to be_nil
    end

    it "extract source id from resource" do
      source = BigML::Source.new('resource' => 'souce/4f66a0b903ce8940c5000000')
      expect(source.id).to eq("4f66a0b903ce8940c5000000")
    end
  end
end
