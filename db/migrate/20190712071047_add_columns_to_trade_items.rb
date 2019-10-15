class AddColumnsToTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_items, :tradeid, :integer
    add_column :trade_items, :from_tradeid, :integer
  end
end
