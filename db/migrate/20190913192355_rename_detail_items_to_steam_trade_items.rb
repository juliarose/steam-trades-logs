class RenameDetailItemsToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :detail_items, :steam_trade_items
  end
end
