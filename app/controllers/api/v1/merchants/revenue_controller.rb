class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    
    render json: RevenueSerializer.new(RevenueFacade.merchant_revenue(merchant))
  end
end
