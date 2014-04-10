require 'spec_helper'

describe ExpensesController do
  
  context "Logged In User" do
  
  login_user

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "GET 'index'" do
    before (:each) do
      @user = FactoryGirl.create(:user)
    end
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
  
  it "should have a current_user" do
      subject.current_user.should_not be_nil
    end
    
    describe "POST js create" do
    
    it "creates a new expense" do
      expect { post :create, format: :js, expense: FactoryGirl.attributes_for(:expense) }.to change(Expense,:count).by(1)
    end
    
  end
  
  end
  
  context "Unauthenticated Visitor" do
    
    describe "GET 'index'" do
      it "does not return http success" do
        get 'index'
        response.should_not be_success
      end
    end
    
    describe "POST js create" do
    
    it "does not js create new expense" do
      expect { post :create, format: :js, expense: FactoryGirl.attributes_for(:expense) }.to change(Expense,:count).by(0)
      response.should_not be_success
    end
  end
    
  end
end
