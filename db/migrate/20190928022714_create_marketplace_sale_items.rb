class CreateMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    create_table :marketplace_sale_items do |t|
      t.references :marketplace_sale, null: false, foreign_key: true
      t.integer :price
      t.integer :item_id
      t.integer :item_original_id
      t.string :full_name
      t.integer :defindex
      t.integer :particle_id
      t.integer :quality_id
      t.integer :killstreak_tier_id
      t.string :skin_name
      t.string :item_name
      t.integer :wear_id
      t.string :sku

      t.timestamps
    end
  end
end
