require "spec_helper"

describe BigML::Prediction, :vcr do

  before(:each) do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
    BigML::Model.delete_all
    BigML::Prediction.delete_all
  end

  describe "no prediction" do
    describe ".all" do
      it "must be empty" do
        BigML::Prediction.all.should == []
      end
    end
  end

  describe "one prediction" do
    before do
      @source = BigML::Source.create("spec/fixtures/iris.csv")
      @dataset = BigML::Dataset.create(@source.resource)
      @model = BigML::Model.create(@dataset.resource)
      @prediction = BigML::Prediction.create(@model.resource, { :input_data => { "000001" => 3 }})
    end

    it "was created successfully" do
      @prediction.code.should == 201
    end

    it "must have only one item" do 
      BigML::Prediction.all.should have(1).predictions
    end

    it "must have the same name" do
      BigML::Prediction.all.first.name.should == "Prediction for species"
    end

    it "must be able to be find using the reference" do
      BigML::Prediction.find(@prediction.id) == @prediction
    end

    it "must be able to update the name" do
      BigML::Prediction.update(@prediction.id, { :name => 'foo name' }).code.should == 202
      BigML::Prediction.find(@prediction.id).name.should == 'foo name'
    end

    it "must be able to remove the prediction" do
      BigML::Prediction.delete(@prediction.id)
      BigML::Prediction.find(@prediction.id).should be_nil
      BigML::Prediction.all.should have(0).predictions
    end
  end
end
