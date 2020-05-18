class RenameItemOriginalIdToAssetOriginalIdOnMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :marketplace_sale_items, :item_original_id, :asset_original_id
  end
end
