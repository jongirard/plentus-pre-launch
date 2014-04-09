require 'spec_helper'

describe DebtPolicy do
  subject { DebtPolicy }
  
    
    permissions :show? do
      @user = FactoryGirl.create(:user)
      @debt = FactoryGirl.create(:debt)
      it "grants access only for user who created it" do
        expect(subject).to permit(@user, Debt.new)
        expect(subject).to_not permit(@user, Debt.last)
      end
    end
end