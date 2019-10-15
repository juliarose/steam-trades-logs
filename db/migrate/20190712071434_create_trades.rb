class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.string :steamid
      t.string :steamid_other
      t.datetime :traded_at
      t.integer :trade_offer_state
      t.string :notes

      t.timestamps
    end
  end
end
