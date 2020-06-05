require "date"

class SteamTrade < ApplicationRecord
  includes LogItem
  
  has_many :steam_trade_items, dependent: :destroy
  
  # only store one trade with tradeofferid for each steamid
  validates_uniqueness_of :tradeofferid, scope: :steamid
  
  # exclude bots from query
  scope :non_bot, -> { where("steamid_other NOT IN (?)", BOTS) }
  
  has_one :bot,
    :primary_key => :steamid,
    :foreign_key => :uid
  
  def is_unusual_sale
    self.steam_trade_items.any? do |steam_trade_item|
      !steam_trade_item.is_their_item && steam_trade_item.quality_id == 5
    end
  end
  
  # gets unusual sales or purchases
  def self.sales_purchases(is_purchase, query_params = ActionController::Parameters.new)
    # build params for queries
    query_params = {
      :is_their_item => is_purchase,
      :quality_id => 5
    }.merge(query_params.permit(:full_name, :steamid, :steamid_other)).compact
    
    # build the query string for selecting items
    where_query_str = query_params.keys.map { |param| "#{param.to_s} = ?" }.join(" AND ")
    
    SteamTrade
      .non_bot
      .includes(:steam_trade_items => :item)
      .where(
          "id in (SELECT steam_trade_id FROM steam_trade_items WHERE #{where_query_str})",
          # pass the query parameters
          *query_params.values
      )
      .order("traded_at DESC")
  end
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone.deep_symbolize_keys
    
    # map related keys to column names
    {
      :timestamp => :traded_at
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # convert date strings to dates
    [
      :traded_at
    ].each do |k|
      data[k] = Date.parse(data[k])
    end
    
    my_items = data[:items] && data[:items][:my]
    them_items = data[:items] && data[:items][:them]
    
    # delete non-column keys before creating our record
    data = data.except(:id).delete_if do |key, value|
      !SteamTrade.column_names.include?(key.to_s)
    end
    
    # create the steam trade object
    steam_trade = SteamTrade.new(data)
    
    [
      [my_items || [], false],
      [them_items || [], true]
    ].each do |index|
      items = index[0]
      is_their_item = index[1]
      
      steam_trade_items = items.map do |item|
        SteamTradeItem.from_json(item)
      end
      
      steam_trade_items.each do |steam_trade_item|
        # change whether this is their item or not
        steam_trade_item.is_their_item = is_their_item
        # build the item onto the trade
        steam_trade.steam_trade_items.build(steam_trade_item.attributes.except(:id))
      end
    end
    
    steam_trade
  end
end
