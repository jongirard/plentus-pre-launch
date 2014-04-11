require 'spec_helper'

describe "Sign Up (invalid plan)" do
  context "GET /register" do
    
    it "redirects to plan selection when plan identifer param is not present" do
      visit register_path
      current_path.should eq page_path("plans")
    end
    it "redirects to plan selection when plan identifier param is invalid" do
      visit register_path(:plan => 'fake')
      current_path.should eq page_path("plans")
    end
  end
end
describe "Sign Up (valid plan)" do

  context "GET /register?plan=core" do
    it "displays the signup user page with form fields on core plan" do
      visit register_path(:plan => 'core')
      
      
      page.should have_button 'SIGN UP FOR CORE'
    end
  end
  context "GET /register?plan=plus" do
    it "displays the signup user page with form fields on plus plan" do
      visit register_path(:plan => 'plus')
      
      
      page.should have_button 'SIGN UP FOR PLUS'
    end
  end
  after(:each) do
    page.should have_field 'user_fullname'
    page.should have_field 'user_email'
    page.should have_select 'user_country_id'
    page.should have_field 'user_password'
  end
end

describe "Validations" do
  
  it "shows a required field error if a required field is blank", :js => true do
     visit register_path(:plan => 'core')
     click_button "SIGN UP"

     expect(page).to have_content("Required Field")
   end

   it "shows an email already exists error if email has already signed up", :js => true do
     user = FactoryGirl.create(:user)
     visit register_path(:plan => 'core')
     fill_in "user_email", with: user.email
     click_button "SIGN UP"
     expect(page).to have_content("Email Address already signed up")
   end

   it "shows an email invalid error if email address is invalid", :js => true do
     user = FactoryGirl.create(:user)
     visit register_path(:plan => 'core')
     fill_in "user_email", with: "user.com"
     click_button "SIGN UP"
     expect(page).to have_content("Email Address is invalid")
   end

   it "shows an invalid name error if illegal characters are present", :js => true do
     visit register_path(:plan => 'core')
     fill_in "user_fullname", with: '<$! Name'
     click_button "SIGN UP"
     expect(page).to have_content("Invalid Characters")
   end
  
end

describe "Registration Process" do
  
  it "shows and sends a confirmation message on successful registration form submission", :js => true do
    user = FactoryGirl.build(:user)
    visit register_path(:plan => 'core')
    fill_in "user_fullname", with: user.fullname
    fill_in "user_email", with: user.email
    select 'Canada', :from => 'user_country_id'
    fill_in "user_password", with: user.password
    click_button "SIGN UP"
    current_path.should eq(new_user_session_path)
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
    last_email.to.should include(user.email)
  end
  
  it "shows an error if a user tries to login after registration without confirmation first", :js => true do
    user = FactoryGirl.build(:user)
    visit register_path(:plan => 'core')
    fill_in "user_fullname", with: user.fullname
    fill_in "user_email", with: user.email
    select 'Canada', :from => 'user_country_id'
    fill_in "user_password", with: user.password
    click_button "SIGN UP"
    current_path.should eq(new_user_session_path)
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
    last_email.to.should include(user.email)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Login"
    expect(page).to have_content("You have to confirm your account before continuing.")
    
  end
end
