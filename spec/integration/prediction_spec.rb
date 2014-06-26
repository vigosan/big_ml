require "spec_helper"

describe BigML::Prediction, :vcr do

  before do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
    BigML::Model.delete_all
    BigML::Prediction.delete_all
  end

  describe "no prediction" do
    describe ".all" do
      it "must be empty" do
        expect(BigML::Prediction.all).to eq([])
      end
    end
  end

  describe "one prediction" do
    let(:source) { BigML::Source.create 'spec/fixtures/iris.csv' }
    let(:dataset) { BigML::Dataset.create source.resource }
    let(:model) { BigML::Model.create dataset.resource }
    let(:prediction) { BigML::Prediction.create model.resource, { input_data: { "000001" => 3 }} }

    it "was created successfully" do
      expect(prediction.code).to eq(201)
    end

    it "must have only one item" do 
      expect(BigML::Prediction.all.length).to eq(1)
    end

    it "must have the same name" do
      expect(BigML::Prediction.all.first.name).to eq("Prediction for species")
    end

    it "must be able to be find using the reference" do
      expect(BigML::Prediction.find(prediction.id).id).to eq(prediction.id)
    end

    it "must be able to update the name" do
      expect(BigML::Prediction.update(prediction.id, { :name => 'foo name' }).code).to eq(202)
      expect(BigML::Prediction.find(prediction.id).name).to eq('foo name')
    end

    it "must be able to update the name from the instance" do
      expect(prediction.update(name: 'foo name').code).to eq(202)
      expect(BigML::Prediction.find(prediction.id).name).to eq('foo name')
    end

    it "must be able to remove the prediction" do
      BigML::Prediction.delete prediction.id
      expect(BigML::Prediction.find prediction.id).to be_nil
      expect(BigML::Prediction.all.length).to eq(0)
    end

    it "must be able to be deleted using the destroy method" do
      prediction_id = prediction.id
      prediction.destroy
      expect(BigML::Prediction.find prediction_id).to be_nil
    end
  end
end
