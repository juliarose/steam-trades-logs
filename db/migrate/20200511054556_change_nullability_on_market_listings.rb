class ChangeNullabilityOnMarketListings < ActiveRecord::Migration[6.0]
  def change
    change_column :market_listings, :date_acted, :date, null: false
    change_column :market_listings, :date_listed, :date, null: false
  end
end
