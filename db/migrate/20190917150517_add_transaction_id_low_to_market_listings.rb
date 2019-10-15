class AddTransactionIdLowToMarketListings < ActiveRecord::Migration[6.0]
  def change
    add_column :market_listings, :transaction_id_low, :string
  end
end
