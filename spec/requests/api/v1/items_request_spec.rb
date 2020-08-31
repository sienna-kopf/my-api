require 'rails_helper'

RSpec.describe "Items API ", type: :request do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    expect(items[:data][0]).to have_key(:id)
    expect(items[:data][0]).to have_key(:type)
    expect(items[:data][0]).to have_key(:attributes)

    expect(items[:data][0][:attributes]).to have_key(:name)
  end

  it "can get one item by id" do
    id =  create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:id]).to eq("#{id}")

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end

  it "can get one item by id" do
    id =  create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:id]).to eq("#{id}")

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)

    expect(item[:data][:attributes]).to have_key(:name)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id

    headers = { "CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", :params => {
      item: {
        name: "Toy Plane",
        description: "Fly your own airplane",
        unit_price: 22.35,
        merchant_id: merchant_id
        }
      }

    expect(response).to be_successful

    new_item = JSON.parse(response.body, symbolize_names: true)
    expect(new_item[:data]).to have_key(:id)
    expect(new_item[:data]).to have_key(:type)
    expect(new_item[:data]).to have_key(:attributes)

    expect(new_item[:data][:attributes]).to have_key(:name)
  end
end
