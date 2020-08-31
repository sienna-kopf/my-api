require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do

  # merchant = create(:merchant)
  # item_1 = create(:item, merchant: merchant )
  #   #pass specific merchant id as argument

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/merchants/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/merchants/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/merchants/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/merchants/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/merchants/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
