require 'spec_helper'

describe Tax do
  it "should be valid and set defaults with blank fields" do
    Tax.new(income: nil, taxes: nil, rrsp: nil).should be_valid
  end
  
  describe '#default_values' do
  
  let(:tax) { FactoryGirl.build(:tax, income: nil, taxes: nil, rrsp: nil) }
  
  it { tax.default_values.should eq "0" }
end
end
