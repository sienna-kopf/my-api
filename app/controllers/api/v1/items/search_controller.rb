class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    keyword = params[attribute]
    if attribute == "name" || attribute == "description"
      item = Item.find_by("items.#{attribute} ILIKE ?", "%#{keyword}%")
    elsif attribute == "created_at" || attribute == "updated_at"
      keyword = keyword.to_s
      item = Item.find_by("DATE(#{attribute}) = ?", "#{keyword}")
    else
      item = Item.find_by("#{attribute} = ?", "#{keyword}")
    end
    render json: ItemSerializer.new(item)
  end

  def index
    attribute = params.keys.first
    keyword = params[attribute]
    if attribute == "name" || attribute == "description"
      item = Item.where("items.#{attribute} ILIKE ?", "%#{keyword}%")
    elsif attribute == "created_at" || attribute == "updated_at"
      keyword = keyword.to_s
      item = Item.where("DATE(#{attribute}) = ?", "#{keyword}")
    else
      item = Item.where("#{attribute} = ?", "#{keyword}")
    end
    render json: ItemSerializer.new(item)
  end
end
