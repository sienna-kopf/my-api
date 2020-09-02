require 'rails_helper'

describe Revenue do
  it 'exists' do
    attrs = {
      revenue: 80.5
    }

    result = Revenue.new(attrs)

    expect(result).to be_a Revenue
    expect(result.id).to eq(nil)
    expect(result.revenue[:revenue]).to eq(80.5)
  end
end
