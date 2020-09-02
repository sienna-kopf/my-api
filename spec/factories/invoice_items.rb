FactoryBot.define do
  factory :invoice_item do
    quantity { "2" }
    unit_price { 5.00 }
    item
    invoice
  end
end
