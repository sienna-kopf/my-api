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
    expect(items[:data][0][:attributes]).to have_key(:description)
    expect(items[:data][0][:attributes]).to have_key(:unit_price)
    expect(items[:data][0][:attributes]).to have_key(:merchant_id)
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
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id

    headers = { "CONTENT_TYPE" => "application/json"}
    item_params = {
        name: "Toy Plane",
        description: "Fly your own airplane",
        unit_price: 22.35,
        merchant_id: merchant_id
      }

    post "/api/v1/items", params: JSON.generate(item_params), headers: headers

    expect(response).to be_successful

    new_item = JSON.parse(response.body, symbolize_names: true)
    expect(new_item[:data]).to have_key(:id)
    expect(new_item[:data]).to have_key(:type)
    expect(new_item[:data]).to have_key(:attributes)

    expect(new_item[:data][:attributes]).to have_key(:name)
    expect(new_item[:data][:attributes]).to have_key(:description)
    expect(new_item[:data][:attributes]).to have_key(:unit_price)
    expect(new_item[:data][:attributes]).to have_key(:merchant_id)
  end

  it "can update an existing item" do
    id = create(:item).id

    headers = { "CONTENT_TYPE" => "application/json"}
    patch "/api/v1/items/#{id}", :params => {name: "Tennis Ball"}

    expect(response).to be_successful
    item = Item.find_by(id: id)
    expect(item.name).to_not eq("Stuffed Giraffe")
    expect(item.name).to eq("Tennis Ball")

    updated_item = JSON.parse(response.body, symbolize_names: true)
    expect(updated_item[:data]).to have_key(:id)
    expect(updated_item[:data]).to have_key(:type)
    expect(updated_item[:data]).to have_key(:attributes)

    expect(updated_item[:data][:attributes]).to have_key(:name)
    expect(updated_item[:data][:attributes]).to have_key(:description)
    expect(updated_item[:data][:attributes]).to have_key(:unit_price)
    expect(updated_item[:data][:attributes]).to have_key(:merchant_id)
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)

    expect(response.status).to eq(204)
  end

  it "sends the merchant associated with a specific item" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(item_merchant.count).to eq(1)

    expect(item_merchant[:data]).to have_key(:id)
    expect(item_merchant[:data]).to have_key(:type)
    expect(item_merchant[:data]).to have_key(:attributes)

    expect(item_merchant[:data][:attributes]).to have_key(:name)
  end
end
