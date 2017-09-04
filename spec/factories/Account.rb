FactoryGirl.define do
  factory :main do
    name { Faker::Company.name }
    association :person, factory: :natural_person
  end
end

FactoryGirl.define do
  factory :branch do
    name { Faker::Company.name }
    association :person, factory: :natural_person
    association :parent, factory: :main
  end
end