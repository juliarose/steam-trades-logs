class AddCraftableToMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    add_column :marketplace_sale_items, :craftable, :boolean, :default => 0, :null => false
  end
end
