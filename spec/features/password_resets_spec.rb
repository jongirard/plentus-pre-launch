require 'spec_helper'

describe "Password Resets" do
  it "emails user when requesting password reset", :js => true do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link "Forgot"
    fill_in "Email", :with => user.email
    click_button "Submit"
    current_path.should eq(new_user_session_path)
    expect(page).to have_content("You will receive an email with instructions about how to reset your password in a few minutes.")
    last_email.to.should include(user.email)
    token = extract_token_from_email(:reset_password) # Here I call the MailHelper module
    visit edit_user_password_path(reset_password_token: token)
    fill_in "user_password", :with => "foobar"
    fill_in "user_password_confirmation", :with => "foobar1"
    click_button "Update Password"
    expect(page).to have_content("Password does not match")
    fill_in "user_password", :with => "foobar"
    fill_in "user_password_confirmation", :with => "foobar"
    click_button "Update Password"
    current_path.should eq(new_user_session_path)
    expect(page).to have_content("Your password was changed successfully.")
  end
  
  it "does not email invalid user when requesting password reset", :js => true do
    visit new_user_session_path
    click_link "Forgot"
    fill_in "Email", :with => "non-existant@email.net"
    click_button "Submit"
    expect(page).to have_content("not found")
    last_email.should be_nil
  end
  
  it "does not reset password if token is invalid", :js => true do
    visit edit_user_password_path(reset_password_token: "abc123")
    fill_in "user_password", :with => "foobar"
    fill_in "user_password_confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Reset password token is invalid")
  end
end