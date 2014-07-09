require "spec_helper"

describe BigML::Evaluation, :vcr do

  before do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
    BigML::Model.delete_all
    BigML::Evaluation.delete_all
  end

  describe "no evaluation" do
    describe ".all" do
      it "must be empty" do
        expect(BigML::Evaluation.all).to eq([])
      end
    end
  end

  describe "one evaluation" do
    let(:source) { BigML::Source.create 'spec/fixtures/iris.csv' }
    let(:dataset) { BigML::Dataset.create source.wait_for_ready.resource }
    let(:model) { BigML::Model.create dataset.wait_for_ready.resource }
    let!(:evaluation) { BigML::Evaluation.create model.wait_for_ready.resource, dataset.wait_for_ready.resource }

    it "was created successfully" do
      expect(evaluation.code).to eq(201)
    end

    it "must have only one item" do 
      expect(BigML::Evaluation.all.length).to eq(1)
    end

    it "must have the same name" do
      expect(BigML::Evaluation.all.first.name).to match(/^Evaluation of iris/)
    end

    it "must be able to be find using the reference" do
      expect(BigML::Evaluation.find(evaluation.id).id).to eq(evaluation.id)
    end

    it "must be able to update the name" do
      expect(BigML::Evaluation.update(evaluation.wait_for_ready.id, { :name => 'foo name' }).code).to eq(202)
      expect(BigML::Evaluation.find(evaluation.id).name).to eq('foo name')
    end

    it "must be able to update the name from the instance" do
      expect(evaluation.wait_for_ready.update(name: 'foo name').code).to eq(202)
      expect(BigML::Evaluation.find(evaluation.id).name).to eq('foo name')
    end

    it "must be able to remove the evaluation" do
      BigML::Evaluation.delete evaluation.id
      expect(BigML::Evaluation.find evaluation.id).to be_nil
      expect(BigML::Evaluation.all.length).to eq(0)
    end

    it "must be able to be deleted using the destroy method" do
      evaluation_id = evaluation.id
      evaluation.destroy
      expect(BigML::Evaluation.find evaluation_id).to be_nil
    end
  end
end
