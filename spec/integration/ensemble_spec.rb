require "spec_helper"

describe BigML::Ensemble, :vcr do

  before do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
    BigML::Ensemble.delete_all
  end

  describe "no ensemble" do
    describe ".all" do
      it "must be empty" do
        expect(BigML::Ensemble.all).to eq([])
      end
    end
  end

  describe "one ensemble" do
    let(:source) { BigML::Source.create 'spec/fixtures/iris.csv' }
    let(:dataset) { BigML::Dataset.create source.wait_for_ready.resource }
    let!(:ensemble) { BigML::Ensemble.create dataset.wait_for_ready.resource, number_of_models: 2 }

    it "was created successfully" do
      expect(ensemble.code).to eq(201)
    end

    it "must have only one item" do
      expect(BigML::Ensemble.all.length).to eq(1)
    end

    it "must have the same size" do
      expect(BigML::Ensemble.all.first.size).to eq(9216)
    end

    it "must be able to set number of models" do
      BigML::Ensemble.create dataset.wait_for_ready.resource, number_of_models: 3
      expect(BigML::Ensemble.all.first.number_of_models).to eq(3)
    end

    it "must be able to be find using the reference" do
      expect(BigML::Ensemble.find(ensemble.id).id).to eq(ensemble.id)
    end

    it "must be able to update the name" do
      expect(BigML::Ensemble.update(ensemble.wait_for_ready.id, { name: 'foo name' }).code).to eq(202)
      expect(BigML::Ensemble.find(ensemble.id).name).to eq('foo name')
    end

    it "must be able to update the name from the instance" do
      expect(ensemble.wait_for_ready.update(name: 'foo name').code).to eq(202)
      expect(BigML::Ensemble.find(ensemble.id).name).to eq('foo name')
    end

    it "must be able to remove the ensemble" do
      BigML::Ensemble.delete ensemble.wait_for_ready.id
      expect(BigML::Ensemble.find ensemble.id).to be_nil
      expect(BigML::Ensemble.all.length).to eq(0)
    end

    it "must be able to be deleted using the destroy method" do
      ensemble_id = ensemble.id
      ensemble.wait_for_ready.destroy
      expect(BigML::Ensemble.find ensemble_id).to be_nil
    end

    it "can be converted in a prediction" do
      prediction = ensemble.wait_for_ready.to_prediction(input_data: { "000001" => 3 })
      expect(ensemble).to be_instance_of(BigML::Ensemble)
      expect(ensemble.code).to eq(201)
    end
  end
end
