module SearchHelper
  
  def parse_query_params(query_parameters)
    query_params = ActionController::Parameters.new(query_parameters).permit(
      :skin_name,
      :quality,
      :item_name,
      :particle,
      :defindex,
      :strange,
      :craftable,
      :australium
    ).transform_keys do |key|
      key = key.to_sym
      # map keys
      maps = {
        :quality => :quality_id,
        :particle => :particle_id
      }
      
      maps[key] || key
    end
    
    # remove empty values
    query_params.reject! do |k, v|
      v.blank?
    end
    
    boolean_fields = [
      :strange,
      :craftable,
      :australium
    ]
    
    boolean_fields.each do |field|
      # don't do anything if this field is nil
      unless query_params[field].nil?
        # will convert the field to a boolean
        query_params[field] = query_params[field].to_i == 1
      end
    end
    
    integer_fields = [
      :quality_id,
      :particle_id,
      :defindex
    ]
    
    integer_fields.each do |field|
      # don't do anything if this field is nil
      unless query_params[field].nil?
        # will convert the field to an int
        query_params[field] = query_params[field].to_i
      end
    end
    
    # convert it to a hash
    query_params.to_h
  end
  
  def parse_steam_trades_query_params(query_parameters)
    query_params = ActionController::Parameters.new(query_parameters).permit(
      :steamid,
      :steamid_other
    )
    
    # convert it to a hash
    query_params.to_h
  end
  
  def steam_trades(query_params, steam_trades_query_params = Hash.new)
    # we want to exclude certain steamids from the results
    bots = DONATION_BOTS + MarketplaceBot.all.map(&:steamid) + Bot.all.map(&:steamid)
    rejected_steamids = (bots + BotOwnership.unique_owners).uniq
    
    steam_trades = SteamTrade
      .joins(:steam_trade_items)
      .where.not(:steamid_other => rejected_steamids)
      .where(:steam_trade_items => query_params)
      .where(steam_trades_query_params)
      .non_cash_trade
      .distinct(:id)
      .order("traded_at DESC")
    
    steam_trades
  end
  
  def marketplace_sale_items(query_params)
    MarketplaceSaleItem
      .joins(:marketplace_sale)
      .includes(:item)
      .where(query_params)
      .order("marketplace_sales.date DESC")
  end
  
  def market_listings(query_params)
    MarketListing
      .includes(:item)
      .where(query_params)
      .order("date_acted DESC")
  end
  
  def preload_steam_trade_items(steam_trades)
    # will preload all items associated with the associated trades
    # I'm not sure if this does anything
    # preloader = 
    ActiveRecord::Associations::Preloader.new(
      records: steam_trades.to_a,
      associations: :steam_trade_items
    ).call
  end
end