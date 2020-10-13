require 'rails_helper'

RSpec.describe "Merchant Multi Finder", type: :request do
  it "can retrieve more than one merchant based on name search case insensitve" do
    Merchant.create!(name: "Guayaki")
    Merchant.create!(name: "Coke Cola")
    Merchant.create!(name: "Pesi Cola")

    get "/api/v1/merchants/find_all?name=cola"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(2)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
  end

  it "can retrieve more than a single merchant based off of created_at date" do
    merchant_1 = Merchant.create!(name: "Guayaki")
    merchant_2 = Merchant.create!(name: "Coke Cola")
    merchant_3 = Merchant.create!(name: "Pesi Cola")

    get "/api/v1/merchants/find_all?created_at=#{merchant_2.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(3)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
  end

  it "can retrieve more than a single merchant based off of updated_at date" do
    merchant_1 = Merchant.create!(name: "Guayaki")
    merchant_2 = Merchant.create!(name: "Coke Cola")
    merchant_3 = Merchant.create!(name: "Pesi Cola")

    get "/api/v1/merchants/find_all?updated_at=#{merchant_2.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(3)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
  end
end
