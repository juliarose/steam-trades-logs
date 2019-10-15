class AddReferenceColumnsToTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :trades, :purchase_steam_trade_id, :integer
    add_column :trades, :purchase_marketplace_purchase_id, :integer
    add_column :trades, :purchase_market_listing_id, :integer
    add_column :trades, :sale_steam_trade_id, :integer
    add_column :trades, :sale_marketplace_sale_id, :integer
    add_column :trades, :sale_market_listing_id, :integer
  end
end
