require 'spec_helper'

describe TaxesController do
  
  login_user

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  it "should have a current_user" do
      # note the fact that I removed the "validate_session" parameter if this was a scaffold-generated controller
      subject.current_user.should_not be_nil
    end
end
