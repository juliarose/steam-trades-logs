module LogInserter
  def self.steam_trades(filename)
    steam_trade_ids = SteamTrade.all.map(&:id)
    
    IO.readlines(filename, chomp: true).each do |line|
      json = JSON.parse(line)
      tradeofferid = json['tradeofferid']
      
      # don't build data for existing trades
      unless steam_trade_ids.include?(tradeofferid)
        steam_trade = SteamTrade.from_json(json)
        steam_trade.save
      end
    end
  end
end