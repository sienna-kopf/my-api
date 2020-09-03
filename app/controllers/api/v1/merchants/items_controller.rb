class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where(merchant_id: params[:id]))
  end

  def most_items
    quantity = params[:quantity]

    render json: MerchantSerializer.new(ItemFacade.merchants_by_items(quantity))
  end
end
