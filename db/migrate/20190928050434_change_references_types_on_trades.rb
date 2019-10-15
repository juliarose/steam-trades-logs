class ChangeReferencesTypesOnTrades < ActiveRecord::Migration[6.0]
  def change
    change_column :trades, :purchase_marketplace_purchase_id, :string
    change_column :trades, :purchase_market_listing_id, :string
    change_column :trades, :sale_marketplace_sale_id, :string
    change_column :trades, :sale_market_listing_id, :string
  end
end
