require "spec_helper"

describe BigML::Source, :vcr do

  before(:each) do
    BigML::Source.delete_all
  end

  describe "no source" do
    describe ".all" do
      it "must be empty" do
        BigML::Source.all.should == []
      end
    end
  end

  describe "one source" do
    before do
      @source = BigML::Source.create("spec/fixtures/iris.csv")
    end

    it "was created successfully" do
      @source.code.should == 201
    end

    it "must have only one item" do 
      BigML::Source.all.should have(1).sources
    end

    it "must have the same file_name" do
      BigML::Source.all.first.file_name.should == "iris.csv"
    end

    it "must be able to be find using the reference" do
      BigML::Source.find(@source.id) == @source
    end

    it "must be able to update the name" do
      BigML::Source.find(@source.id).name.should == 'iris.csv'
      BigML::Source.update(@source.id, { :name => 'new name' }).code.should == 202
      BigML::Source.find(@source.id).name.should == 'new name'
    end

    it "must be able to update the name from the instance" do
      BigML::Source.find(@source.id).name.should == 'iris.csv'
      @source.update( :name => 'new name' ).code.should == 202
      BigML::Source.find(@source.id).name.should == 'new name'
    end

    it "must be able to remove the source" do
      BigML::Source.delete(@source.id)
      BigML::Source.find(@source.id).should be_nil
      BigML::Source.all.should have(0).sources
    end

    it "must be able to be deleted using the destroy method" do
      source_id = @source.id
      @source.destroy
      BigML::Source.find(source_id).should be_nil
    end

    it "can be converted in a dataset" do
      dataset = @source.to_dataset
      dataset.instance_of?(BigML::Dataset).should be_true
      dataset.code.should == 201
    end
  end
end
