class ChangeColumnTypesOnSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    change_column :steam_trade_items, :classid, :bigint
    change_column :steam_trade_items, :instanceid, :bigint
  end
end
