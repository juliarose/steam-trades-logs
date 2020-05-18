class RenameSteamTradeItemsToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :steam_trade_items, :steam_trade_items
  end
end
