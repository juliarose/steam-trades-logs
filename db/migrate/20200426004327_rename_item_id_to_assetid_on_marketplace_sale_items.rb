class RenameItemIdToAssetidOnMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :marketplace_sale_items, :item_id, :assetid
  end
end
