require 'spec_helper'

describe ProgressiveTaxer do
  context "no taxes on init" do
    before :each do
      @taxer = ProgressiveTaxer.new
    end

    it "defaults to 0 tax" do
      expect(@taxer.tax 5340).to eq(0)
      expect(@taxer.tax 152030).to eq(0)
    end

    it "accepts single tax amounts" do
      @taxer.add_tax 10000, 0.05
      expect(@taxer.tax 9999).to eq(0)
      expect(@taxer.tax 11000).to eq(50)
      expect(@taxer.tax 20000).to eq(500)
    end

    it "accepts multiple tax amounts" do
      @taxer.add_tax 0, 0.05
      @taxer.add_tax 7000, 0.1
      expect(@taxer.tax 5000).to eq(250)
      expect(@taxer.tax 10000).to eq(650)
    end

    it "accepts tax amounts in any order" do
      @taxer.add_tax 6000, 0.1
      expect(@taxer.tax 5000).to eq(0)
      expect(@taxer.tax 7000).to eq(100)
      @taxer.add_tax 0, 0.05
      expect(@taxer.tax 5000).to eq(250)
      expect(@taxer.tax 7000).to eq(400)
    end
  end

  context "taxes added from file" do
    before :each do
      @taxer = ProgressiveTaxer.new filename:'taxes/federal.2013.single.taxes'
    end

    it "does not default to 0" do
      expect(@taxer.tax 123000).to_not eq(0)
    end

    it "should provide a correct tax" do
      expect(@taxer.tax 5000).to eq(500)
      expect(@taxer.tax 8925).to eq(892.5)
      expect(@taxer.tax 36250).to eq(4991.25)
      expect(@taxer.tax 400000).to eq(116163.75)
    end
  end
end