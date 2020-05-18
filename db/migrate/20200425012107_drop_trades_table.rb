class DropTradesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :trades
  end
end
