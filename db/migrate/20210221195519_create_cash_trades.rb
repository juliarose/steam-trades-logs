class CreateCashTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_trades do |t|
      t.date :date
      t.string :steamid
      t.string :tradeid
      t.references :steam_trade, null: false, foreign_key: true
      t.string :txid
      t.string :email
      t.integer :keys
      t.integer :usd
      t.string :processor
      t.text :notes

      t.timestamps
    end
  end
end
