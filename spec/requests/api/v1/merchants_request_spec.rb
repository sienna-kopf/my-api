require 'rails_helper'

RSpec.describe "Merchants API", type: :request do

  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    expect(merchants[:data][0]).to have_key(:id)
    expect(merchants[:data][0]).to have_key(:type)
    expect(merchants[:data][0]).to have_key(:attributes)

    expect(merchants[:data][0][:attributes]).to have_key(:name)
  end

  it "can get one merchant by id" do
    id =  create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq("#{id}")

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data]).to have_key(:attributes)

    expect(merchant[:data][:attributes]).to have_key(:name)
  end

  it "can create a new merchant" do
    headers = { "CONTENT_TYPE" => "application/json"}
    merchant_params = { name: "Toy Plane Emporium" }

    post "/api/v1/merchants", params: JSON.generate(merchant_params), headers: headers

    expect(response).to be_successful

    new_merchant = JSON.parse(response.body, symbolize_names: true)
    expect(new_merchant[:data]).to have_key(:id)
    expect(new_merchant[:data]).to have_key(:type)
    expect(new_merchant[:data]).to have_key(:attributes)

    expect(new_merchant[:data][:attributes]).to have_key(:name)
  end

  it "can update an existing merchant" do
    merchant_id = create(:merchant).id

    headers = { "CONTENT_TYPE" => "application/json"}
    patch "/api/v1/merchants/#{merchant_id}", :params => {name: "Hello Kitty Kingdom"}

    expect(response).to be_successful
    merchant = Merchant.find_by(id: merchant_id)
    expect(merchant.name).to_not eq("Josh's Dog Shop")
    expect(merchant.name).to eq("Hello Kitty Kingdom")

    updated_merchant = JSON.parse(response.body, symbolize_names: true)
    expect(updated_merchant[:data]).to have_key(:id)
    expect(updated_merchant[:data]).to have_key(:type)
    expect(updated_merchant[:data]).to have_key(:attributes)

    expect(updated_merchant[:data][:attributes]).to have_key(:name)
  end

  it "can destroy an item" do
    merchant = create(:merchant)

    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant)
    payment = create(:payment, invoice: invoice)

    item_1 = create(:item, merchant: merchant)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.50, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant)

    invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
    invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 45.50, item_id: item_2.id, invoice_id: invoice.id)
    invoice_item_3 = InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice.id)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{InvoiceItem.find(invoice_item_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{InvoiceItem.find(invoice_item_2.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{InvoiceItem.find(invoice_item_3.id)}.to raise_error(ActiveRecord::RecordNotFound)

    expect(response.status).to eq(204)
  end

  it "sends a list of items associated with that merchant" do
    merchant = create(:merchant)
    create(:item, merchant: merchant)
    create(:item, merchant: merchant)
    create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_items[:data].count).to eq(3)

    expect(merchant_items[:data][0]).to have_key(:id)
    expect(merchant_items[:data][0]).to have_key(:type)
    expect(merchant_items[:data][0]).to have_key(:attributes)

    expect(merchant_items[:data][0][:attributes]).to have_key(:name)
    expect(merchant_items[:data][0][:attributes]).to have_key(:description)
    expect(merchant_items[:data][0][:attributes]).to have_key(:unit_price)
    expect(merchant_items[:data][0][:attributes]).to have_key(:merchant_id)
  end
end
