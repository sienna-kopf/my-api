require 'rails_helper'

RSpec.describe "Item Single Finder", type: :request do
  it "can retrieve more than 1 item based on name search case-insensitve" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.50, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.75, merchant: merchant)

    get "/api/v1/items/find?name=animal"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(2)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes]).to have_key(:unit_price)
  end

  it "can retrieve more than 1 item based off of shared unit price" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 5.55, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Dinosaur", description: "Based off the hit pictionary game", unit_price: 5.55, merchant: merchant)

    get "/api/v1/items/find?unit_price=5.55"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to have_key(3)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes]).to have_key(:unit_price)
  end

  it "can retrieve more than 1 item based off of shared merchant_id" do
    merchant = create(:merchant)
    item_1 = create(:item)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 5.55, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Dinosaur", description: "Based off the hit pictionary game", unit_price: 5.55, merchant: merchant)

    get "/api/v1/items/find?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to have_key(2)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes]).to have_key(:unit_price)
  end

  it "can retrieve multiple items based off of same created_at date" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.50, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Dinosaur", description: "Based off the hit pictionary game", unit_price: 5.75, merchant: merchant)

    get "/api/v1/items/find?created_at=#{item_3.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(3)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes]).to have_key(:unit_price)
  end

  it "can retrieve multiple items based off of same updated_at date" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.50, merchant: merchant)
    item_3 = Item.create!(name: "Drawsaurus Stuffed Dinosaur", description: "Based off the hit pictionary game", unit_price: 5.75, merchant: merchant)

    get "/api/v1/items/find?updated_at=#{item_3.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(3)

    expect(item[:data][0]).to have_key(:id)
    expect(item[:data][0]).to have_key(:type)
    expect(item[:data][0]).to have_key(:attributes)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes]).to have_key(:unit_price)
  end
end
