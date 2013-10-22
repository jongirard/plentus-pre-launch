require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    
    it "should have the title 'home'" do
      visit '/pages/home'
      expect(page).to have_title("Plentus | Home")
    end
    
    it "should have the content 'Plentus is a web app'" do
      visit '/pages/home'
      expect(page).to have_content('Plentus is a web app')
    end
  end
end
