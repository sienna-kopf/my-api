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

  it "can return the merchants with the most revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = Merchant.create!(name: "Stuffed Animal Shop")
    merchant_3 = Merchant.create!(name: "Barn O' Stuff")

    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)
    payment = create(:payment, invoice: invoice_1)
    payment = create(:payment, invoice: invoice_2)
    payment = create(:payment, invoice: invoice_3)

    item_1 = create(:item, merchant: merchant_2)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.00, merchant: merchant_1)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant_2)
    item_4 = Item.create!(name: "Saddle", description: "Ride a horse with it", unit_price: 100.00, merchant: merchant_3)

    create(:invoice_item, invoice: invoice_2, item: item_1)
    InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice_2.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100.00, item_id: item_4.id, invoice_id: invoice_3.id)
    InvoiceItem.create!(quantity: 2, unit_price: 45.00, item_id: item_2.id, invoice_id: invoice_1.id)

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_successful

    revenue = JSON.parse(response.body, symbolize_names: true)

    expect(revenue[:data].count).to eq(2)

    expect(revenue[:data][0]).to have_key(:id)
    expect(revenue[:data][0]).to have_key(:type)
    expect(revenue[:data][0]).to have_key(:attributes)

    expect(revenue[:data][0][:attributes]).to have_key(:name)
    expect(revenue[:data][0][:attributes][:name]).to eq("Barn O' Stuff")
    expect(revenue[:data][1][:attributes][:name]).to eq("Josh's Dog Shop")
  end

  it "can return the merchants with the most items" do
    merchant_1 = create(:merchant)
    merchant_2 = Merchant.create!(name: "Stuffed Animal Shop")
    merchant_3 = Merchant.create!(name: "Barn O' Stuff")

    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)
    payment = create(:payment, invoice: invoice_1)
    payment = create(:payment, invoice: invoice_2)
    payment = create(:payment, invoice: invoice_3)

    item_1 = create(:item, merchant: merchant_2)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.00, merchant: merchant_1)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant_2)
    item_4 = Item.create!(name: "Saddle", description: "Ride a horse with it", unit_price: 100.00, merchant: merchant_3)
    item_5 = Item.create!(name: "Spurs", description: "Cow boot spikes", unit_price: 20.50, merchant: merchant_3)
    item_6 = Item.create!(name: "Space Dino Beanie Baby", description: "Galexy dinosaur", unit_price: 4.50, merchant: merchant_2)

    create(:invoice_item, invoice: invoice_2, item: item_1)
    InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice_2.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100.00, item_id: item_4.id, invoice_id: invoice_3.id)
    InvoiceItem.create!(quantity: 2, unit_price: 45.00, item_id: item_2.id, invoice_id: invoice_1.id)
    InvoiceItem.create!(quantity: 3, unit_price: 20.50, item_id: item_5.id, invoice_id: invoice_3.id)
    InvoiceItem.create!(quantity: 4, unit_price: 4.50, item_id: item_6.id, invoice_id: invoice_2.id)

    get "/api/v1/merchants/most_items?quantity=2"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(2)

    expect(merchants[:data][0]).to have_key(:id)
    expect(merchants[:data][0]).to have_key(:type)
    expect(merchants[:data][0]).to have_key(:attributes)

    expect(merchants[:data][0][:attributes]).to have_key(:name)
    expect(merchants[:data][0][:attributes][:name]).to eq("Stuffed Animal Shop")
    expect(merchants[:data][1][:attributes][:name]).to eq("Barn O' Stuff")
  end
end
