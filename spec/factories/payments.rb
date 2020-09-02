FactoryBot.define do
  factory :payment do
    credit_card_number { "1234 5678 8901 1234" }
    result { "success" }
    invoice
  end
end
