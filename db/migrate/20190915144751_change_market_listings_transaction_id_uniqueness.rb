class ChangeMarketListingsTransactionIdUniqueness < ActiveRecord::Migration[6.0]
  def change
    change_column :market_listings, :transaction_id, :string, unique: true
  end
end
