require 'faker' 

FactoryGirl.define do 
  factory :user do |u| 
    u.fullname { Faker::Name.name } 
    u.email { Faker::Internet.email }
    u.country_id '1039'
    u.password { '123456' }
    u.income { 15000 }
  end 
end