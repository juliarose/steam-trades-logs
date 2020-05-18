class FixInstanceidClassidColumnsFromSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :steam_trade_items, :class_id, :classid
    rename_column :steam_trade_items, :instance_id, :instanceid
  end
end
