class AddSkinNameToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :skin_name, :string
  end
end
