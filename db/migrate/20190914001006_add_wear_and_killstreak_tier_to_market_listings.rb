class AddWearAndKillstreakTierToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :wear_id, :integer
    add_column :market_listings, :killstreak_tier_id, :integer
  end
end
