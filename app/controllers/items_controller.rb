class ItemsController < ApplicationController
  before_action :force_json, only: :search
  
  # autocomplete search
  def search
    query = params[:q].downcase
    
    @items = Item
      .where("length(item_name) < 100")
      .where("item_name LIKE ?", "%#{query}%")
      .select("DISTINCT item_name")
      .limit(5)
  end
  
  private
  
  # forces response as json
  def force_json
    request.format = :json
  end
end