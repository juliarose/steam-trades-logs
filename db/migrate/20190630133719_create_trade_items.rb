class CreateTradeItems < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_items do |t|
      t.bigint :assetid
      t.integer :appid
      t.integer :contextid
      t.string :item_name
      t.integer :defindex
      t.boolean :craftable
      t.string :skin_name
      t.integer :killstreak_tier_id
      t.integer :wear_id
      t.integer :particle_id
      t.integer :quality_id
      t.date :purchased_at
      t.date :sold_at
      t.decimal :keys_spent
      t.decimal :scm_spent
      t.decimal :usd_spent
      t.decimal :items_spent
      t.decimal :keys_received
      t.decimal :scm_received
      t.decimal :usd_received
      t.decimal :items_received
      t.string :notes
      t.string :steamid
      t.string :steamid_other

      t.timestamps
    end
  end
end
