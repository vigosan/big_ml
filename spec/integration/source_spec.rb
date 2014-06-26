require "spec_helper"

describe BigML::Source, :vcr do

  before do
    BigML::Source.delete_all
  end

  describe "no source" do
    describe ".all" do
      it "must be empty" do
        expect(BigML::Source.all).to eq([])
      end
    end
  end

  describe "one source" do
    let(:source) { BigML::Source.create 'spec/fixtures/iris.csv' }

    it "was created successfully" do
      expect(source.code).to eq(201)
    end

    it "must have only one item" do 
      expect(BigML::Source.all.length).to eq(1)
    end

    it "must have the same file_name" do
      expect(BigML::Source.all.first.file_name).to eq("iris.csv")
    end

    it "must be able to be find using the reference" do
      expect(BigML::Source.find(source.id).id).to eq(source.id)
    end

    it "must be able to update the name" do
      expect(BigML::Source.find(source.id).name).to eq('iris.csv')
      expect(BigML::Source.update(source.id, { name: 'new name' }).code).to eq(202)
      expect(BigML::Source.find(source.id).name).to eq('new name')
    end

    it "must be able to update the name from the instance" do
      expect(BigML::Source.find(source.id).name).to eq('iris.csv')
      expect(source.update(name: 'new name').code).to eq(202)
      expect(BigML::Source.find(source.id).name).to eq('new name')
    end

    it "must be able to remove the source" do
      BigML::Source.delete source.id
      expect(BigML::Source.find source.id).to be_nil
      expect(BigML::Source.all.length).to eq(0)
    end

    it "must be able to be deleted using the destroy method" do
      source_id = source.id
      source.destroy
      expect(BigML::Source.find source_id).to be_nil
    end

    it "can be converted in a dataset" do
      dataset = source.to_dataset
      expect(dataset).to be_instance_of(BigML::Dataset)
      expect(dataset.code).to eq(201)
    end
  end
end
