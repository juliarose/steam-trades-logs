class ChangeMarketListingsIconUrlToText < ActiveRecord::Migration[6.0]
  def change
    change_column :market_listings, :icon_url, :text
  end
end
