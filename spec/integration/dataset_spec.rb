require "spec_helper"

describe BigML::Dataset, :vcr do

  before do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
  end

  describe "no dataset" do
    describe ".all" do
      it "must be empty" do
        expect(BigML::Dataset.all).to eq([])
      end
    end
  end

  describe "one dataset" do
    let(:source) { BigML::Source.create "spec/fixtures/iris.csv" }
    let(:dataset) { BigML::Dataset.create source.resource }

    it "was created successfully" do
      expect(dataset.code).to eq(201)
    end

    it "must have only one item" do 
      expect(BigML::Dataset.all.length).to eq(1)
    end

    it "must have the same file_name" do
      expect(BigML::Dataset.all.first.size).to eq(4608)
    end

    it "must be able to be find using the reference" do
      expect(BigML::Dataset.find(dataset.id).id).to eq(dataset.id)
    end

    it "must be able to update the name" do
      expect(BigML::Dataset.update(dataset.id, { name: 'foo name' }).code).to eq(202)
      expect(BigML::Dataset.find(dataset.id).name).to eq('foo name')
    end

    it "must be able to update the name from the instance" do
      expect(dataset.update(name: 'foo name').code).to eq(202)
      expect(BigML::Dataset.find(dataset.id).name).to eq('foo name')
    end

    it "must be able to be deleted using the destroy method" do
      dataset_id = dataset.id
      dataset.destroy
      expect(BigML::Dataset.find(dataset_id)).to be_nil
    end

    it "must be able to remove the dataset" do
      BigML::Dataset.delete(dataset.id)
      expect(BigML::Dataset.find(dataset.id)).to be_nil
      expect(BigML::Dataset.all.length).to eq(0)
    end

    it "can be converted in a model" do
      model = dataset.to_model
      expect(model).to be_instance_of(BigML::Model)
      expect(model.code).to eq(201)
    end
  end
end
