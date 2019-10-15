class CreateMarketplaceSales < ActiveRecord::Migration[6.0]
  def change
    create_table :marketplace_sales do |t|
      t.integer :earned_credit
      t.string :transaction_id
      t.datetime :date

      t.timestamps
    end
  end
end
