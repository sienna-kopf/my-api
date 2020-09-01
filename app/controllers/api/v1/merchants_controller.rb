class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
