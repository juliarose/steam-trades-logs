class ChangeReferenceTypesOnTrades < ActiveRecord::Migration[6.0]
  def change
    change_column :trades, :purchase_steam_trade_id, :bigint
    change_column :trades, :sale_steam_trade_id, :bigint
  end
end
