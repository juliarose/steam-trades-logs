class AddSkinIdToMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    add_column :marketplace_sale_items, :skin_id, :integer
  end
end
