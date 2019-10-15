class ChangeParticleAndQualityNameFromMarketListings < ActiveRecord::Migration[6.0]
  def change
    rename_column :market_listings, :quality, :quality_id
    rename_column :market_listings, :particle, :particle_id
  end
end
