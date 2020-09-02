class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    revenue = merchant.invoices.joins(:invoice_items).joins(:payments).select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("payments.result = 'success' AND status = 'shipped'").group(:id).order("revenue desc").first

    render json: RevenueSerializer.new(revenue)
  end
end
