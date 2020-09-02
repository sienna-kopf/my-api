FactoryBot.define do
  factory :invoice do
    status { "shipped" }
    customer
    merchant
  end
end
