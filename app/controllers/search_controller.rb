class SearchController < ApplicationController
  authorize_resource class: false, :except => [:sales, :steam_trades_sales, :marketplace_sales, :market_listings_sales]
  
  # gets details for the given item
  def index
    @query_params = helpers.parse_query_params(request.query_parameters)
    steam_trades_query_params = helpers.parse_steam_trades_query_params(request.query_parameters)
    
    @steam_trades = helpers.steam_trades(@query_params, steam_trades_query_params)
    @market_listings = helpers.market_listings(@query_params)
    
    @pagy_marketplace_sale_items, @marketplace_sale_items = pagy(
      helpers
        .marketplace_sale_items(@query_params),
      link_extra: 'data-remote="true"',
      request_path: '/search/marketplace_sales'
    )
    @pagy_steam_trades_sales, @steam_trades_sales = pagy(
      @steam_trades
        .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => false })),
      link_extra: 'data-remote="true" data-action="search#steam_trades_sales"',
      request_path: '/search/steam_trades/sales'
    )
    @pagy_steam_trades_purchases, @steam_trades_purchases = pagy(
      @steam_trades
        .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => true })),
      link_extra: 'data-remote="true" data-action="search#steam_trades_purchases"',
      request_path: '/search/steam_trades/purchases'
    )
    @pagy_market_listings_sales, @market_listings_sales = pagy(
      @market_listings
        .where(:is_credit => true),
      link_extra: 'data-remote="true"',
      request_path: '/search/market_listings/sales'
    )
    @pagy_market_listings_purchases, @market_listings_purchases = pagy(
      @market_listings
        .where(:is_credit => false),
      link_extra: 'data-remote="true"',
      request_path: '/search/market_listings/purchases'
    )
    
    # will preload all items associated with the associated trades
    helpers.preload_steam_trade_items(@steam_trades_sales)
    helpers.preload_steam_trade_items(@steam_trades_purchases)
  end
  
  def sales
    @query_params = helpers.parse_query_params(request.query_parameters)
    steam_trades_query_params = helpers.parse_steam_trades_query_params(request.query_parameters)
    
    @steam_trades = helpers.steam_trades(@query_params, steam_trades_query_params)
    @market_listings = helpers.market_listings(@query_params)
    
    @marketplace_sale_items = helpers.marketplace_sale_items(@query_params)
      .paginate(page: params[:page], per_page: 20)
    @steam_trades_sales = @steam_trades
      .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => false }))
      .paginate(page: params[:page], per_page: 20)
    @market_listings_sales = @market_listings
      .where(:is_credit => true)
      .paginate(page: params[:page], per_page: 20)
    
    # will preload all items associated with the associated trades
    helpers.preload_steam_trade_items(@steam_trades_sales)
  end
  
  def purchases
    @query_params = helpers.parse_query_params(request.query_parameters)
    steam_trades_query_params = helpers.parse_steam_trades_query_params(request.query_parameters)
    
    @steam_trades = helpers.steam_trades(@query_params, steam_trades_query_params)
    @market_listings = helpers.market_listings(@query_params)
    
    @steam_trades_purchases = @steam_trades
      .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => true }))
      .paginate(page: params[:page], per_page: 20)
    @market_listings_purchases = @market_listings
      .where(:is_credit => false)
      .paginate(page: params[:page], per_page: 20)
    
    # will preload all items associated with the associated trades
    helpers.preload_steam_trade_items(@steam_trades_purchases)
  end
  
  def steam_trades
    @query_params = helpers.parse_query_params(request.query_parameters)
    steam_trades_query_params = helpers.parse_steam_trades_query_params(request.query_parameters)
    
    @steam_trades = helpers.steam_trades(@query_params, steam_trades_query_params)
    
    @steam_trades_sales = @steam_trades
      .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => false }))
      .paginate(page: params[:page], per_page: 20)
    @steam_trades_purchases = @steam_trades
      .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => true }))
      .paginate(page: params[:page], per_page: 20)
    
    # will preload all items associated with the associated trades
    helpers.preload_steam_trade_items(@steam_trades_sales)
    helpers.preload_steam_trade_items(@steam_trades_purchases)
  end
  
  def steam_trades_sales
    @query_params = helpers.parse_query_params(request.query_parameters)
    steam_trades_query_params = helpers.parse_steam_trades_query_params(request.query_parameters)
    
    @steam_trades = helpers.steam_trades(@query_params, steam_trades_query_params)
    @pagy_steam_trades_sales, @steam_trades_sales = pagy(@steam_trades
      .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => false }))
    )
    
    helpers.preload_steam_trade_items(@steam_trades_sales)
    
    respond_to do |format|
      format.html { render template: "steam_trades/index" }
      format.js { render template: "search/steam_trades_sales" }
    end
  end
  
  def steam_trades_purchases
    @query_params = helpers.parse_query_params(request.query_parameters)
    steam_trades_query_params = helpers.parse_steam_trades_query_params(request.query_parameters)
    
    @steam_trades = helpers.steam_trades(@query_params, steam_trades_query_params)
    @pagy_steam_trades_purchases, @steam_trades_purchases = pagy(@steam_trades
      .where(:steam_trade_items => @query_params.clone.merge({ :is_their_item => true }))
    )
    
    helpers.preload_steam_trade_items(@steam_trades_purchases)
    
    respond_to do |format|
      format.html { render template: "steam_trades/index" }
      format.js { render template: "search/steam_trades_purchases" }
    end
  end
  
  def marketplace_sales
    @query_params = helpers.parse_query_params(request.query_parameters)
    
    @pagy_marketplace_sale_items, @marketplace_sale_items = pagy(
      helpers.marketplace_sale_items(@query_params)
    )
    
    respond_to do |format|
      format.html { render template: "marketplace_sale_items/index" }
      format.js { render template: "search/marketplace_sales" }
    end
  end
  
  def market_listings_sales
    @query_params = helpers.parse_query_params(request.query_parameters)
    
    @market_listings = helpers.market_listings(@query_params)
    @pagy_market_listings_sales, @market_listings_sales = pagy(@market_listings
      .where(:is_credit => true)
    )
    
    respond_to do |format|
      format.html { render template: "market_listings/index" }
      format.js { render template: "search/market_listings_sales" }
    end
  end
  
  def market_listings_purchases
    @query_params = helpers.parse_query_params(request.query_parameters)
    
    @market_listings = helpers.market_listings(@query_params)
    @pagy_market_listings_purchases, @market_listings_purchases = pagy(@market_listings
      .where(:is_credit => false)
    )
    
    respond_to do |format|
      format.html { render template: "market_listings/index" }
      format.js { render template: "search/market_listings_purchases" }
    end
  end
end