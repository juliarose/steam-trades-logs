class InsertSteamTradesFromFileJob < ApplicationJob
  
  # this is very inefficent but is really only used one time for building initial data from old logs
  def perform(filepath)
    # get array of all keys stored in database
    steam_trade_keys = SteamTrade.select("steamid, tradeofferid").all.map do |steam_trade|
      [steam_trade.steamid, steam_trade.tradeofferid].join('_')
    end
    
    # these files can be quite large (~700mb) so we process these line-by-line
    # doing all-at-once can cause us to run out of memory
    IO.readlines(filepath, chomp: true).each do |line|
      # skip blank lines
      next if line.strip.empty?
      
      json = JSON.parse(line).deep_symbolize_keys
      steam_trade_key = [json[:steamid], json[:tradeofferid]].join('_')
      
      unless steam_trade_keys.include?(steam_trade_key)
        SteamTrade.from_json(json).save
      end
    end
  end
end