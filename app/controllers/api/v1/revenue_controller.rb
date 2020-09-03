class Api::V1::RevenueController < ApplicationController
  def show
    start_date = params[:start]
    end_date = params[:end]
    render json: RevenueSerializer.new(RevenueFacade.date_range_revenue(start_date, end_date))
  end
end
