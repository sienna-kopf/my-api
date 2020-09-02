class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    keyword = params[attribute]
    if attribute == "name"
      merchant = Merchant.where("merchants.#{attribute} ILIKE ?", "%#{keyword}%").limit(1)
    elsif attribute == "created_at" || attribute == "updated_at"
      keyword = keyword.to_s
      merchant = Merchant.where("DATE(#{attribute}) = ?", "#{keyword}").limit(1)
    else
      merchant = Merchant.where("#{attribute} = ?", "#{keyword}").limit(1)
    end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    attribute = params.keys.first
    keyword = params[attribute]
    if attribute == "name"
      merchant = Merchant.where("merchants.#{attribute} ILIKE ?", "%#{keyword}%")
    elsif attribute == "created_at" || attribute == "updated_at"
      keyword = keyword.to_s
      merchant = Merchant.where("DATE(#{attribute}) = ?", "#{keyword}")
    else
      merchant = Merchant.where("#{attribute} = ?", "#{keyword}")
    end
    render json: MerchantSerializer.new(merchant)
  end
end
