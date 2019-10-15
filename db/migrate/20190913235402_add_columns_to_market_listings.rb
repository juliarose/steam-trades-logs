class AddColumnsToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :defindex, :integer
    add_column :market_listings, :particle, :integer
    add_column :market_listings, :full_name, :string
    add_column :market_listings, :quality, :integer
  end
end
