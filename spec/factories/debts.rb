# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :debt do
    interest_annual "9.99"
    duration 5
    present_balance 500
    future_value 0
    budget_monthly 50
    user
  end
end
