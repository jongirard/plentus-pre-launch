require 'spec_helper'

describe DeductionPolicy do
  subject { DeductionPolicy }
  
    
    permissions :show? do
      @user = FactoryGirl.create(:user)
      @deduction = FactoryGirl.create(:deduction)
      it "grants access only for user who created it" do
        expect(subject).to permit(@user, Deduction.new)
        expect(subject).to_not permit(@user, Deduction.last)
      end
    end
end