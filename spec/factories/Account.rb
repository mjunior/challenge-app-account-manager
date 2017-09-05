FactoryGirl.define do
  factory :main do
    name { Faker::Company.name }
    association :person, factory: :natural_person
    factory :main_with_branches do
      after(:create) do |article|
        create_list(:branch, 5, parent: article)
      end
    end
  end
end

FactoryGirl.define do
  factory :branch do
    name { Faker::Company.name }
    association :person, factory: :natural_person
    association :parent, factory: :main
  end
end