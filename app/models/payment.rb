class Payment < ApplicationRecord
  validates_presence_of :credit_card_number, :credit_card_expiration_date, :result
  belongs_to :invoice
end
