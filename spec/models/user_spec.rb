require 'spec_helper'

describe User do
  context "Model" do
  it "has a valid factory" do
    user = FactoryGirl.build(:user).should be_valid
end

  it "is invalid without a name" do
    FactoryGirl.build(:user, fullname: nil).should_not be_valid
end
  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
end
  it "is invalid with an already used email" do
    user = FactoryGirl.create(:user)
    User.new(:fullname => 'Plentus User', :email => 'user.email').should_not be_valid

  end

  it "should save when required fields are populated with valid data" do
    user = FactoryGirl.build(:user).save.should == true
end
end
end