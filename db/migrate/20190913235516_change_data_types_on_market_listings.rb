class ChangeDataTypesOnMarketListings < ActiveRecord::Migration[6.0]
  def change
    change_column :market_listings, :appid, :integer
    change_column :market_listings, :contextid, :integer
    change_column :market_listings, :assetid, :bigint
    change_column :market_listings, :classid, :bigint
    change_column :market_listings, :instanceid, :bigint
  end
end
