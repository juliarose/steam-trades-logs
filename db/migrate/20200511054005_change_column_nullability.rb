class ChangeColumnNullability < ActiveRecord::Migration[6.0]
  def change
    change_column :steam_trades, :traded_at, :datetime, null: false
    change_column :marketplace_sales, :earned_credit, :integer, null: false
    change_column :marketplace_sales, :transaction_id, :string, null: false
    change_column :marketplace_sale_items, :price, :integer, null: false
    change_column :market_listings, :transaction_id, :string, null: false
    change_column :market_listings, :price, :integer, null: false
  end
end
