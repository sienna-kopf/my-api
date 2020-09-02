class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    InvoiceItem.where(item_id: params[:id]).delete_all
    Item.delete(params[:id])
  end

  def merchant
    item = Item.find(params[:id])
    render json: MerchantSerializer.new(item.merchant)
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end
