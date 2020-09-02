class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    keyword = params[attribute]
    if attribute == "name" || attribute == "description"
      item = Item.where("items.#{attribute} ILIKE ?", "%#{keyword}%").limit(1)
    elsif attribute == "created_at" || attribute == "updated_at"
      item = Item.where("DATE(#{attribute}) LIKE ?", "%#{keyword}%").limit(1)
    else
      item = Item.where("#{attribute} = ?", "#{keyword}").limit(1)
    end
    render json: ItemSerializer.new(item)
  end
end
