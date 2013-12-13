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
  
  describe "Feature Tour" do
  
  it "does have the correct page title" do
  visit '/tour'
  expect(page).to have_title("Plentus - Tour")
end

  it "does have sub navigation (features menu)" do
  visit '/tour'
  expect(page).to have_link('Dashboard')
  expect(page).to have_link('Analytics')
  expect(page).to have_link('Cloud-Based')
  expect(page).to have_link('Conversations')
  expect(page).to have_link('Support')
end
end

describe "Pricing Page" do

it "does have the correct page title" do
visit '/pricing'
expect(page).to have_title("Plentus - Pricing")
end

it "does have correct plans, core and plus" do
  visit '/pricing'
  expect(page).to have_selector('p.identifier', text: 'CORE')
  expect(page).to have_selector('p.identifier', text: 'PLUS')
end
it "does have plan select link(s)" do
  visit '/pricing'
  expect(page).to have_link('GET STARTED TODAY')
end
end
end

