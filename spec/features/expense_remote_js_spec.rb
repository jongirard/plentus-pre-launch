require 'spec_helper'

describe "expense index" do
    before(:each) do
    user = FactoryGirl.create(:user)
    user.confirm!
    login_as(user, :scope => :user)
  end
  
  context "no expenses" do
    
    it "should contain link 'add expense'" do
      visit index_expense_path
      expect(page).to have_link("Add Expense")
    end
    
    context "remote expenses" do
    it "should load 'expenses/new' remote dropdown", :js => true do
      visit index_expense_path
      click_link "Add Expense"
      expect(page).to have_css('li.dropdown.open')
      expect(page).to have_css('form#new_expense')
      within(:css, 'form#new_expense') { expect(page).to have_button('Add Expense') }
    end
    
    it "should appear using js when added through dropdown form", :js => true do
      visit index_expense_path
      click_link "New Expense"
      expect(page).to have_css('li.dropdown.open')
      fill_in('expense[name]', :with => 'Rent')
      fill_in('expense[flexible_amount]', :with => '$650')
      within(:css, 'form#new_expense') { click_button('Add Expense') }
      within(:css, '#recurring_expenses') { expect(page).to have_content('Rent') }
    end
  end
  
  end
end