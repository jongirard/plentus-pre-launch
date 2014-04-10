require 'spec_helper'

describe Deduction do
  it "should be valid and set defaults with blank fields" do
    Deduction.new(home_sqf: nil, business_sqf: nil, monthly_expenses: nil, business_kilometers: nil, start_kilometers: nil, vehicle_expenses: nil, short_flight: nil, short_meal: nil, short_entertainment: nil, short_lodging: nil, long_flight: nil, long_meal: nil, long_entertainment: nil, long_lodging: nil).should be_valid
  end
end
