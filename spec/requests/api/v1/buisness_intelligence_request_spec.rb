require 'rails_helper'

RSpec.describe "Buisness Intelligence Endpoints", type: :request do
  it "can return the total revenue for a single merchant" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant)
    payment = create(:payment, invoice: invoice)

    item_1 = create(:item, merchant: merchant)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.50, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant)

    create(:invoice_item, invoice: invoice, item: item_1)
    InvoiceItem.create!(quantity: 1, unit_price: 45.50, item_id: item_2.id, invoice_id: invoice.id)
    InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice.id)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_successful

    revenue = JSON.parse(response.body, symbolize_names: true)

    expect(revenue[:data]).to have_key(:id)
    expect(revenue[:data][:id]).to eq(nil)
    expect(revenue[:data]).to have_key(:attributes)

    expect(revenue[:data][:attributes]).to have_key(:revenue)
  end
end
