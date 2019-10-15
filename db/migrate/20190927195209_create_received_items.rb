class CreateReceivedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :received_items do |t|
      t.references :steam_trade, null: false, foreign_key: true
      t.references :steam_trade_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
