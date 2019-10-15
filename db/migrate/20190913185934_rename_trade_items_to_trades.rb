class RenameTradeItemsToTrades < ActiveRecord::Migration[6.0]
  def change
    rename_table :trade_items, :trades
  end
end
