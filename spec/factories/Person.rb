FactoryGirl.define do
  factory :natural_person do
    full_name { Faker::Internet.email }
    cpf CPF.generate()
    birthdate { Time.now }
    type 'NaturalPerson'
  end

  factory :legal_person do
    company_name { Faker::Company.name  }
    trade_name { Faker::Company.name  }
    cnpj CNPJ.generate()
    type 'LegalPerson'
  end
end