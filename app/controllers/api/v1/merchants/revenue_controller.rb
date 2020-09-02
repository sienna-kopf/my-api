class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])

    render json: RevenueSerializer.new(RevenueFacade.merchant_revenue(merchant))
  end

  def index
    quantity = params[:quantity]

    render json: MerchantSerializer.new(RevenueFacade.merchants_by_revenue(quantity))
  end
end
