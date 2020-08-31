require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    it { should validate_presence_of :credit_card_number}
    it { should validate_presence_of :result}
    it { should validate_presence_of :credit_card_expiration_date}
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end
end
