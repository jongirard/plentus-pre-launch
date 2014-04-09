require 'spec_helper'

describe "Login Process" do
  
  it "shows a success message if sign in is successful", :js => true do
    user = FactoryGirl.create(:user)
    user.confirm!
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Login"
    expect(page).to have_content("Signed in successfully")
    
  end
end