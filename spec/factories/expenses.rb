# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    name "MyString"
    flexible_amount "$25"
    expense_type "Other"
    user
  end
end
