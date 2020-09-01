class Payment < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  belongs_to :invoice
end
