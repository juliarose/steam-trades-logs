class PurchasesController < ApplicationController
  # load_and_authorize_resource :class => false

  def index
    @steam_trades = SteamTrade
      .sales_purchases(true, params)
      .paginate(page: nil, per_page: 20)
    @market_listings = MarketListing
      .sales_purchases(true, params)
      .paginate(page: nil, per_page: 20)
  end
  
  def steam_trades
    @steam_trades = SteamTrade
      .sales_purchases(true, params)
      .paginate(page: params[:page], per_page: 20)
    
    respond_to do |format|
      format.html { render template: "steam_trades/index" }
      format.js { render template: "purchases/steam_trades" }
    end
  end
  
  def market_listings
    @market_listings = MarketListing
      .sales_purchases(true, params)
      .paginate(page: params[:page], per_page: 20)
    
    respond_to do |format|
      format.html { render template: "market_listings/index" }
      format.js { render template: "purchases/market_listings" }
    end
  end
end