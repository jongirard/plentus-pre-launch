# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :debt do
    interest_annual "9.99"
    interest_monthly "9.99"
    duration 1
    present_balance 1
    future_value 1
    budget_monthly 1
  end
end
