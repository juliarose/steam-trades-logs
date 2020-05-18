class AddAustraliumToMarketplaceSaleItems < ActiveRecord::Migration[6.0]
  def change
    add_column :marketplace_sale_items, :australium, :boolean
  end
end
