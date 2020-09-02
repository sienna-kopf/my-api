require 'rails_helper'

RSpec.describe "Merchant Single Finder", type: :request do
  it "can retrieve a single merchant based on an attribute search part of name" do
    merchant_1 = Merchant.create!(name: "Guayaki")
    merchant_2 = Merchant.create!(name: "Coke Cola")
    merchant_3 = Merchant.create!(name: "Pesi Cola")

    get "/api/v1/merchants/find?name=Co"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end

  it "can retrieve a single merchant based on an attribute search full name" do
    merchant_1 = Merchant.create!(name: "Guayaki")
    merchant_2 = Merchant.create!(name: "Coke Cola")
    merchant_3 = Merchant.create!(name: "Pesi Cola")

    get "/api/v1/merchants/find?name=Cola"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end

  it "can retrieve a single merchant case-insensitve" do
    merchant_1 = Merchant.create!(name: "Guayaki")
    merchant_2 = Merchant.create!(name: "Coke Cola")
    merchant_3 = Merchant.create!(name: "Pesi Cola")

    get "/api/v1/merchants/find?name=cola"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end

  it "can retrieve a single merchant based off of created_at date" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end

  it "can retrieve a single merchant based off of updated_at date" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end
end
