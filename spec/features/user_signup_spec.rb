require 'spec_helper'

describe "Sign Up" do
  context "GET /register" do
    it "displays the signup user page with form fields" do
      visit register_path
      
      page.should have_field 'user_fullname'
      page.should have_field 'user_email'
      page.should have_button 'Sign up'
    end
    it "does have the correct page title" do
      visit register_path
      expect(page).to have_title("Plentus - Beta Sign Up")
    end 
  end

describe "Signup Process" do
    
  it "shows a required field error if a required field is blank", :js => true do
    visit register_path
    click_button "Sign up"

    expect(page).to have_content("Required Field")
  end
  
  it "Shows an email already exists error if email has already signed up", :js => true do
    user = FactoryGirl.create(:user)
    visit register_path
    fill_in "user_fullname", with: user.fullname
    fill_in "user_email", with: user.email
    click_button "Sign up"
    expect(page).to have_content("Email Address already signed up")
  end
  
  it "shows a devise:confirmable message on successful registration form submission", :js => true do
    user = FactoryGirl.build(:user)
    visit register_path
    fill_in "user_fullname", with: user.fullname
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign up"
    current_path.should eq(login_path)
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
  end
end
end
