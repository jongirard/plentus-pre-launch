require 'faker' 

FactoryGirl.define do 
  factory :post do |entry| 
    entry.guid { Faker::Number.number(2) }
    entry.author { Faker::Name.name } 
    entry.name { Faker::Lorem.sentence(4) }
  end 
end