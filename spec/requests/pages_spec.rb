require 'spec_helper'

describe "Pages" do
  
   it "does have navigation" do
      visit '/home'
      expect(page).to have_link('Features')
      expect(page).to have_link('Pricing')
      expect(page).to have_link('Blog')
      expect(page).to have_link('Sign Up')
    end
    
  describe "Home page" do
    
    it "does have the correct page title" do
      visit '/home'
      expect(page).to have_title("Plentus - Personalized Financial Management")
    end
    
    it "does have the content 'Manage your pursuit of'" do
      visit '/home'
      expect(page).to have_content('Manage your pursuit of')
    end
    
    it "does have the link 'SIGN UP'" do
      visit '/home'
      expect(page).to have_link('SIGN UP')
    end
  end
  
  describe "Features Pages" do
  
  it "does have the correct page title" do
  visit '/overview'
  expect(page).to have_title("Plentus - Overview")
end

  it "does have sub navigation (features menu)" do
  visit '/overview'
  expect(page).to have_link('OVERVIEW')
  expect(page).to have_link('CONVERSATIONS')
  expect(page).to have_link('TRACKING')
  expect(page).to have_link('BUDGETING')
  expect(page).to have_link('SUPPORT')
end
end

describe "Blog Page" do
  it "does have the correct page title" do
  visit '/blog'
  expect(page).to have_title("Plentus Blog - Recent Posts")
end
end
end

