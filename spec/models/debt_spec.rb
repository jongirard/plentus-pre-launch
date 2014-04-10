require 'spec_helper'

describe Debt do
  it "should be valid and set defaults with blank fields" do
    Debt.new(interest_annual: nil, duration: nil, present_balance: nil, future_value: nil, budget_monthly: nil).should be_valid
  end
end
