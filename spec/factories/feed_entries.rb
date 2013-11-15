# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_entry do
    title "MyString"
    summary "MyText"
    author "MyString"
    published_at "2013-11-12 23:58:01"
    guid "MyString"
  end
end
