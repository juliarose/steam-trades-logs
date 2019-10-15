class AddItemNameToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :item_name, :string
  end
end
