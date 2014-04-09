# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deduction do
    home_sqf 100
    business_sqf 50
    monthly_expenses 100
    business_kilometers 50
    start_kilometers 200
    vehicle_expenses 100
    short_flight 100
    short_meal 1
    short_entertainment 1
    short_lodging 1
    long_flight 1
    long_meal 1
    long_entertainment 1
    long_lodging 1
    user
  end
end
