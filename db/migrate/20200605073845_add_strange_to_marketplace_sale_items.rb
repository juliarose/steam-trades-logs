class AddStrangeToMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    add_column :marketplace_sale_items, :strange, :boolean, :default => 0, :null => false
  end
end
