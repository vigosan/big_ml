require "spec_helper"

describe BigML::Model, :vcr do

  before(:each) do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
    BigML::Model.delete_all
  end

  describe "no model" do
    describe ".all" do
      it "must be empty" do
        BigML::Model.all.should == []
      end
    end
  end

  describe "one model" do
    before do
      @source = BigML::Source.create("spec/fixtures/iris.csv")
      @dataset = BigML::Dataset.create(@source.resource)
      @model = BigML::Model.create(@dataset.resource)
    end

    it "was created successfully" do
      @model.code.should == 201
    end

    it "must have only one item" do 
      BigML::Model.all.should have(1).models
    end

    it "must have the same size" do
      BigML::Model.all.first.size.should == 4608
    end

    it "must be able to be find using the reference" do
      BigML::Model.find(@model.id) == @model
    end

    it "must be able to update the name" do
      BigML::Model.update(@model.id, { :name => 'foo name' }).code.should == 202
      BigML::Model.find(@model.id).name.should == 'foo name'
    end

    it "must be able to remove the model" do
      BigML::Model.delete(@model.id)
      BigML::Model.find(@model.id).should be_nil
      BigML::Model.all.should have(0).models
    end
  end
end
