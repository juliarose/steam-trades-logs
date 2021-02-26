class ErrorsController < ApplicationController
  
  def not_found
    @steam_trade_item = SteamTradeItem.random_unusual
  end
end
