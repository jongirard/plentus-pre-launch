require 'spec_helper'

describe RegistrationsController do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  context "Invalid or No Plan Param" do
    
    describe "GET 'new'" do
    it "should return http redirect" do
      get 'new'
      response.should redirect_to page_path('plans')
    end
  end
  
  describe "POST 'create'" do
  it "should not be success and redirect" do
    post :create, user: FactoryGirl.attributes_for(:user)
    response.should_not be_success
    response.should redirect_to page_path('plans')
  end
end
    
  end
  
  context "Valid Plan Param" do
    describe "GET 'new'" do
    it "should be success" do
      @param = ['core', 'plus']
        @param.each do |param|
        get :new, :plan => param
        response.should be_success
      end
    end
  end
  
  describe "POST 'create'" do
  it "should create new user record and redirect" do
    expect { post :create, :plan => 'core', user: FactoryGirl.attributes_for(:user) }.to change(User,:count).by(1)
    response.should redirect_to new_user_session_path 
  end
end
end
  
end