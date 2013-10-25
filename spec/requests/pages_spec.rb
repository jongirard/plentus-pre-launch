require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    
    it "does have the title 'home'" do
      visit '/pages/home'
      expect(page).to have_title("Plentus | Home")
    end
    
    it "does have the content 'Plentus is a web app'" do
      visit '/pages/home'
      expect(page).to have_content('Plentus is a web app')
    end
    
    it "does have the link 'SIGN UP'" do
      visit '/pages/home'
      expect(page).to have_link('SIGN UP')
    end
  end
end
