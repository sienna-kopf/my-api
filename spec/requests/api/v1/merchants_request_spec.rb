require 'rails_helper'

RSpec.describe "Merchants API", type: :request do

  # merchant = create(:merchant)
  # item_1 = create(:item, merchant: merchant )
  #   #pass specific merchant id as argument
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

  it "can create a new item" do

    headers = { "CONTENT_TYPE" => "application/json"}
    post "/api/v1/merchants", :params => {
      merchant: {
        name: "Hello Kitty Kingdom"
        }
      }

    expect(response).to be_successful

    new_merchant = JSON.parse(response.body, symbolize_names: true)
    expect(new_merchant[:data]).to have_key(:id)
    expect(new_merchant[:data]).to have_key(:type)
    expect(new_merchant[:data]).to have_key(:attributes)

    expect(new_merchant[:data][:attributes]).to have_key(:name)
  end

  it "can update an existing item" do
    merchant_id = create(:merchant).id

    headers = { "CONTENT_TYPE" => "application/json"}
    patch "/api/v1/merchants/#{merchant_id}", :params => {
      merchant: {
        name: "Hello Kitty Kingdom"
        }
      }

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

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)

    deleted_merchant = JSON.parse(response.body, symbolize_names: true)

    binding.pry

    expect(deleted_merchant[:data]).to have_key(:status)
    expect(deleted_merchant[:data][:status]).to eq(204)
    expect(deleted_merchant[:data]).to have_key(:error)
    expect(deleted_merchant[:data]).to have_key(:exception)
  end
end
