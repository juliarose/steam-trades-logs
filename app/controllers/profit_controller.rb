class ProfitController < ApplicationController
  
  def index
    since = 1.month.ago
    purchases = SteamTrade.sales_purchases({ :is_their_item => false })
    
  end
end
