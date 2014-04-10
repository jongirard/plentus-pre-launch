require 'spec_helper'

describe "Gon Income" do
  
   before(:each) do
    user = FactoryGirl.create(:user)
    user.confirm!
    login_as(user, :scope => :user)
  end
  
 it "should be present on new tax calculator form if income is set", :js => true do
  visit new_tax_path
  expect(page).to have_css('form#new_tax')
  assert page.has_field?('tax[flexible_income]', :with => '15000') 
   
 end
end