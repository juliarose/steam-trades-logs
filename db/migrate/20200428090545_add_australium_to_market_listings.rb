class AddAustraliumToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :australium, :boolean
  end
end
