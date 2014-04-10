require 'spec_helper'

describe DebtsController do
  
  context "Logged In User" do
  
  login_user

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "GET 'index' with debts" do
    it "returns http success" do
      post :create, debt: FactoryGirl.attributes_for(:debt) 
      get 'index'
      response.should be_success
    end
  end
  
  it "should have a current_user" do
      subject.current_user.should_not be_nil
    end
    
    describe "POST create" do
    
    it "creates a new tax" do
      expect { post :create, debt: FactoryGirl.attributes_for(:debt) }.to change(Debt,:count).by(1)
    end
    
    it "redirects to the new tax" do 
      post :create, debt: FactoryGirl.attributes_for(:debt) 
      response.should redirect_to show_debt_path(Debt.last)
    end 
  end
  
  end
  
  context "Unauthenticated Visitor" do
    
    describe "GET 'new'" do
      it "does not return http success" do
        get 'new'
        response.should_not be_success
      end
    end
    
  end
end
