FactoryGirl.define do
  factory :transaction do

    transient do
      origin_param nil
      destination_param nil
      type 'nil'
    end

    origin { origin_param }
    destination { destination_param }
    transaction_type { type }
    amount 100
  end
end
