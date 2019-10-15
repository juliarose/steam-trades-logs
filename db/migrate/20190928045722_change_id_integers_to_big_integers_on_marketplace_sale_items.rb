class ChangeIdIntegersToBigIntegersOnMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    change_column :marketplace_sale_items, :item_id, :bigint
    change_column :marketplace_sale_items, :item_original_id, :bigint
  end
end
