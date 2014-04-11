require 'spec_helper'

describe TaxPolicy do
  subject { TaxPolicy }
  
    
    permissions :show? do
      @user = FactoryGirl.create(:user)
      @tax = FactoryGirl.create(:tax)
      it "grants access only for user who created it" do
        expect(subject).to permit(@user, Tax.new)
        expect(subject).to_not permit(@user, Tax.last)
      end
    end
end