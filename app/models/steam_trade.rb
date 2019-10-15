require 'date'

class SteamTrade < ApplicationRecord
  has_many :steam_trade_items, dependent: :destroy
  
  def given_items
    self.steam_trade_items.select { |steam_trade_item| !steam_trade_item.is_their_item }
  end
  
  def received_items
    self.steam_trade_items.select { |steam_trade_item| steam_trade_item.is_their_item }
  end
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone
    
    # map related keys to column names
    {
      'tradeofferid' => 'id',
      'timestamp' => 'traded_at'
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # convert date strings to dates
    [
      'traded_at'
    ].each do |k|
      data[k] = Date.parse(data[k])
    end
    
    my_items = data['items'] && data['items']['my']
    them_items = data['items'] && data['items']['them']
    
    # delete non-column keys before creating our record
    data.delete_if do |key, value|
      !self.column_names.include?(key)
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
        steam_trade.steam_trade_items.build(steam_trade_item.attributes.except('id'))
      end
    end
    
    steam_trade
  end
end
