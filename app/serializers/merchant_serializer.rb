class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  attributes :name
end
