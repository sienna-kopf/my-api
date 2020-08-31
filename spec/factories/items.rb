FactoryBot.define do
  factory :item do
    name { "Stuffed Giraffe" }
    description { "Cute Dog Toy." }
    unit_price { 5.55 }
    merchant
  end
end
