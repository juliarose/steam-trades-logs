class CreateDetailItems < ActiveRecord::Migration[6.0]
  def change
    create_table :detail_items do |t|
      t.bigint :assetid
      t.integer :appid
      t.integer :contextid
      t.integer :defindex
      t.boolean :craftable
      t.string :skin_name
      t.integer :killstreak_tier_id
      t.integer :wear_id
      t.integer :particle_id
      t.integer :quality_id
      t.integer :tradeid
      t.boolean :is_their_item
      t.string :item_name
      t.string :full_name

      t.timestamps
    end
  end
end
