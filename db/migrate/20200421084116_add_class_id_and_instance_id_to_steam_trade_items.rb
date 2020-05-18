class AddClassIdAndInstanceIdToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trade_items, :class_id, :integer
    add_column :steam_trade_items, :instance_id, :integer
  end
end
