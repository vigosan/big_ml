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
   end
end
