require "spec_helper"

describe BigML::Model, :vcr do

  before do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
    BigML::Model.delete_all
  end

  describe "no model" do
    describe ".all" do
      it "must be empty" do
        expect(BigML::Model.all).to eq([])
      end
    end
  end

  describe "one model" do
    let(:source) { BigML::Source.create 'spec/fixtures/iris.csv' }
    let(:dataset) { BigML::Dataset.create source.resource }
    let(:model) { BigML::Model.create dataset.resource }

    it "was created successfully" do
      expect(model.code).to eq(201)
    end

    it "must have only one item" do
      expect(BigML::Model.all.length).to eq(1)
    end

    it "must have the same size" do
      expect(BigML::Model.all.first.size).to eq(4608)
    end

    it "must be able to be find using the reference" do
      expect(BigML::Model.find(model.id).id).to eq(model.id)
    end

    it "must be able to update the name" do
      expect(BigML::Model.update(model.id, { name: 'foo name' }).code).to eq(202)
      expect(BigML::Model.find(model.id).name).to eq('foo name')
    end

    it "must be able to update the name from the instance" do
      expect(model.update(name: 'foo name').code).to eq(202)
      expect(BigML::Model.find(model.id).name).to eq('foo name')
    end

    it "must be able to remove the model" do
      BigML::Model.delete model.id
      expect(BigML::Model.find model.id).to be_nil
      expect(BigML::Model.all.length).to eq(0)
    end

    it "must be able to be deleted using the destroy method" do
      model_id = model.id
      model.destroy
      expect(BigML::Model.find model_id).to be_nil
    end

    it "can be converted in a prediction" do
      prediction = model.to_prediction(input_data: { "000001" => 3 })
      expect(prediction).to be_instance_of(BigML::Prediction)
      expect(prediction.code).to eq(201)
    end
  end
end
