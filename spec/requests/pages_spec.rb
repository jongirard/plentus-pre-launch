require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    
    it "does have the title 'home'" do
      visit '/pages/home'
      expect(page).to have_title("Plentus - Personalized Financial Management")
    end
    
    it "does have the content 'Manage your pursuit of'" do
      visit '/pages/home'
      expect(page).to have_content('Manage your pursuit of')
    end
    
    it "does have the link 'SIGN UP'" do
      visit '/pages/home'
      expect(page).to have_link('SIGN UP')
    end
  end
end
