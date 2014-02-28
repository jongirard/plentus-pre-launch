# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deduction do
    home_sqf 1
    business_sqf 1
    monthly_expenses 1
    business_kilometers 1
    start_kilometers 1
    vehicle_expenses 1
    short_flight 1
    short_meal 1
    short_entertainment 1
    short_lodging 1
    long_flight 1
    long_meal 1
    long_entertainment 1
    long_lodging 1
  end
end
