# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    name "MyString"
    amount 1
    expense_date "2014-03-09"
    expense_type ""
  end
end
