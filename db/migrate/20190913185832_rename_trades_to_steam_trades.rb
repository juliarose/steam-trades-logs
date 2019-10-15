class RenameTradesToSteamTrades < ActiveRecord::Migration[6.0]
  def change
    rename_table :trades, :steam_trades
  end
end
