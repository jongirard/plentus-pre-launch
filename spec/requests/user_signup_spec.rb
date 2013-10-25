require 'spec_helper'

describe "UserSignup" do
  context "GET /sign_up" do
    it "displays the signup user page with form fields" do
      visit sign_up_path
      
      page.should have_field 'user_fullname'
      page.should have_field 'user_email'
      page.should have_button 'Sign up'
    end
  end
  
  it "shows a thank you message on successful form submission" do
    user = FactoryGirl.create(:user)
    visit sign_up_path
    fill_in "user_fullname", with: user.fullname
    fill_in "user_email", with: user.email
    click_button "Sign up"
    current_path.should eq(sign_up_path)
    page.should have_content("Thank you")
  end
end
