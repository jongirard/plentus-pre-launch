require 'spec_helper'

describe TrendsController do
  
  context "Logged In User" do
  
  login_user

  describe "GET 'index'" do
    before (:each) do
      @user = FactoryGirl.create(:user)
    end
    context "Expense Records" do
    it "returns http success" do
      FactoryGirl.create(:expense, user: subject.current_user)
      get 'index'
      response.should be_success
    end
  end
  
  context "No Expenses" do
    
    it "returns http redirect to expense path" do
      get 'index'
      response.should redirect_to index_expense_path
    end
  end
end
  
  it "should have a current_user" do
      subject.current_user.should_not be_nil
    end
  end
  
  context "Unauthenticated Visitor" do
    
    describe "GET 'index'" do
      it "does not return http success" do
        get 'index'
        response.should_not be_success
      end
    end
    
  end
end
