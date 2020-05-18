class OptimizeSteamTradeItemColumns < ActiveRecord::Migration[6.0]
  def change
    # reduce columns down to  more appropriate integer integer sizes
    change_column :steam_trade_items, :particle_id, :smallint
    change_column :steam_trade_items, :quality_id, :tinyint
    change_column :steam_trade_items, :killstreak_tier_id, :tinyint
    change_column :steam_trade_items, :wear_id, :tinyint
    change_column :steam_trade_items, :appid, :smallint
    change_column :steam_trade_items, :contextid, :smallint
    change_column :steam_trade_items, :defindex, :mediumint
  end
end
