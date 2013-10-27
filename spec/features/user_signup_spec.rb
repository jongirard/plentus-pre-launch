require 'spec_helper'

describe "signup page" do
  context "GET /sign_up" do
    it "displays the signup user page with form fields" do
      visit sign_up_path
      
      page.should have_field 'user_fullname'
      page.should have_field 'user_email'
      page.should have_button 'Sign up'
    end
  end
end

describe "signup process" do
    
  it "shows a validation error if a field is blank", :js => true do
    visit sign_up_path
    click_button "Sign up"

    expect(page).to have_content("Required Field")
  end
  
  it "shows a thank you message on successful form submission", :js => true do
    user = FactoryGirl.create(:user)
    visit sign_up_path
    fill_in "user_fullname", with: user.fullname
    fill_in "user_email", with: user.email
    click_button "Sign up"
    current_path.should eq(sign_up_path)
    expect(page).to have_content("Thank you. You will be notified of our launch at #{user.email}.")
  end
end
