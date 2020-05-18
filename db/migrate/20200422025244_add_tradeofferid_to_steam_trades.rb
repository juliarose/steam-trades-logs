class AddTradeofferidToSteamTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trades, :tradeofferid, :integer
  end
end
