require 'faker' 

FactoryGirl.define do 
  factory :user do |u| 
    u.fullname { Faker::Name.name } 
    u.email { Faker::Internet.email }
  end 
end