class AddStrangeToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :strange, :boolean, :default => 0, :null => false
  end
end
