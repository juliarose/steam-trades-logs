class RemoveColumnsFromTrades < ActiveRecord::Migration[6.0]
  def change
    remove_column :trades, :tradeid
    remove_column :trades, :from_tradeid
  end
end
