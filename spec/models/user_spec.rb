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
  it "is invalid without a country_id" do
    FactoryGirl.build(:user, country_id: nil).should_not be_valid
end
it "is invalid without a password" do
  FactoryGirl.build(:user, password: nil).should_not be_valid
end
  it "is invalid with a duplicate email address" do
    user = FactoryGirl.create(:user)
    User.new(:fullname => 'Plentus User', :email => 'user.email', :password => '123456').should_not be_valid
end
it "should not approve incorrect roles" do
  @user = FactoryGirl.create(:user)
  @user.add_role :role
  @user.has_role?(:admin).should be_false
end

it "should approve correct roles" do
  @user = FactoryGirl.create(:user)
  @user.add_role :role
  @user.has_role?(:role).should be_true
end

  it "should save when required fields are populated with valid data" do
    user = FactoryGirl.build(:user).save.should == true
end
end
end