require "spec_helper"

describe BigML::Dataset, :vcr do

  before(:each) do
    BigML::Source.delete_all
    BigML::Dataset.delete_all
  end

  describe "no dataset" do
    describe ".all" do
      it "must be empty" do
        BigML::Dataset.all.should == []
      end
    end
  end

  describe "one dataset" do
    before do
      @source = BigML::Source.create("spec/fixtures/iris.csv")
      @dataset = BigML::Dataset.create(@source.resource)
    end

    it "was created successfully" do
      @dataset.code.should == 201
    end

    it "must have only one item" do 
      BigML::Dataset.all.should have(1).datasets
    end

    it "must have the same file_name" do
      BigML::Dataset.all.first.size.should == 4608
    end

    it "must be able to be find using the reference" do
      BigML::Dataset.find(@dataset.id) == @dataset
    end

    it "must be able to update the name" do
      BigML::Dataset.update(@dataset.id, { :name => 'foo name' }).code.should == 202
      BigML::Dataset.find(@dataset.id).name.should == 'foo name'
    end

    it "must be able to update the name from the instance" do
      @dataset.update(:name => 'foo name').code.should == 202
      BigML::Dataset.find(@dataset.id).name.should == 'foo name'
    end

    it "must be able to be deleted using the destroy method" do
      dataset_id = @dataset.id
      @dataset.destroy
      BigML::Dataset.find(dataset_id).should be_nil
    end

    it "must be able to remove the dataset" do
      BigML::Dataset.delete(@dataset.id)
      BigML::Dataset.find(@dataset.id).should be_nil
      BigML::Dataset.all.should have(0).datasets
    end

    it "can be converted in a model" do
      model = @dataset.to_model
      model.instance_of?(BigML::Model).should be_true
      model.code.should == 201
    end
  end
end
