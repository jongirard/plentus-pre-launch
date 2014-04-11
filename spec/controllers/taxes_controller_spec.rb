require 'spec_helper'

describe TaxesController do
  
  context "Logged In User" do
  
  login_user

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  it "should have a current_user" do
      subject.current_user.should_not be_nil
    end
    
    describe "POST create" do
    
    it "creates a new tax" do
      expect { post :create, tax: FactoryGirl.attributes_for(:tax) }.to change(Tax,:count).by(1)
    end
    
    it "redirects to the new tax" do 
      post :create, tax: FactoryGirl.attributes_for(:tax) 
      response.should redirect_to show_tax_path(Tax.last)
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
