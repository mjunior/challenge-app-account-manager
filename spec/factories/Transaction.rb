FactoryGirl.define do
  factory :transaction do

    transient do
      origin_account nil
      destination_account nil
      type nil
    end

    origin { origin_account }
    destination { destination_account }
    transaction_type { type }
    token {SecureRandom.hex(12) }
    amount 100
  end
end
