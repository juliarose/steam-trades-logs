class SalesController < ApplicationController
  
  def index
    @steam_trades = SteamTrade
      .sales_purchases(false, params)
      .paginate(page: nil, per_page: 20)
    @marketplace_sale_items = MarketplaceSaleItem
      .sales(params)
      .paginate(page: nil, per_page: 20)
    @market_listings = MarketListing
      .sales_purchases(false, params)
      .paginate(page: nil, per_page: 20)
  end
  
  def steam_trades
    @steam_trades = SteamTrade
      .sales_purchases(false, params)
      .paginate(page: params[:page], per_page: 20)
    
    respond_to do |format|
      format.html { render template: "steam_trades/index" }
      format.js { render template: "sales/steam_trades" }
    end
  end
  
  def marketplace_sales
    @marketplace_sale_items = MarketplaceSaleItem
      .sales(params)
      .paginate(page: params[:page], per_page: 20)
    
    respond_to do |format|
      format.html { render template: "marketplace_sale_items/index" }
      format.js { render template: "sales/marketplace_sales" }
    end
  end
  
  def market_listings
    @market_listings = MarketListing
      .sales_purchases(false, params)
      .paginate(page: params[:page], per_page: 20)
    
    respond_to do |format|
      format.html { render template: "market_listings/index" }
      format.js { render template: "sales/market_listings" }
    end
  end
end
