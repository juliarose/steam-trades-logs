class CreateMarketListings < ActiveRecord::Migration[6.0]
  def change
    create_table :market_listings do |t|
      t.string :transaction_id
      t.string :transaction_id_high
      t.integer :index
      t.string :appid
      t.string :contextid
      t.boolean :is_credit
      t.string :name
      t.string :market_name
      t.string :market_hash_name
      t.string :name_color
      t.string :background_color
      t.string :assetid
      t.string :classid
      t.string :instanceid
      t.string :icon_url
      t.date :date_acted
      t.date :date_listed
      t.integer :price
      t.string :seller

      t.timestamps
    end
  end
end
