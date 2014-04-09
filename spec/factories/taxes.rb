# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tax do
    income 15000
    taxes 50
    rrsp 1
    user
  end
end
