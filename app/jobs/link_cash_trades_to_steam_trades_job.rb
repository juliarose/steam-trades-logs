class LinkCashTradesToSteamTradesJob < ApplicationJob
  
  def perform
    cash_trades = CashTrade.where(:steam_trade_id => nil)
    cash_trade_steam_trade_ids = CashTrade.all.map(&:steam_trade_id).compact
    
    cash_trades.each do |cash_trade|
      date = cash_trade.date
      steam_trades = SteamTrade.where(:steamid_other => cash_trade.steamid, :traded_at => (date.beginning_of_day - 1.day)..(date.end_of_day + 1.day))
      
      steam_trade = steam_trades.find do |steam_trade|
        steam_trade.steam_trade_items.count == cash_trade.keys
      end
      
      if steam_trade
        cash_trade.steam_trade_id = steam_trade.id
        cash_trade.save
      end
    end
  end
end