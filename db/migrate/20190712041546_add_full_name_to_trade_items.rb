class AddFullNameToTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_items, :full_name, :string
  end
end
