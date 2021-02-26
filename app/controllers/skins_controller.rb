class SkinsController < ApplicationController
  before_action :force_json, only: :search
  
  # autocomplete search
  def search
    query = params[:q].downcase
    
    @skins = Skin
      .where("name LIKE ?", "%#{query}%")
      .select("DISTINCT name")
      .limit(5)
  end
  
  private
  
  # forces response as json
  def force_json
    request.format = :json
  end
end