class ChangeColumnsOnSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :steam_trade_items, :is_their_item
    remove_column :steam_trade_items, :tradeid
  end
end
