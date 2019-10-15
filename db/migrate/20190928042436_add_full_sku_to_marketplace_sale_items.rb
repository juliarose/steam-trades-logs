class AddFullSkuToMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    add_column :marketplace_sale_items, :full_sku, :string
  end
end
