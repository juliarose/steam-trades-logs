class ChangeNullabilityOnMarketplaceSales < ActiveRecord::Migration[6.0]
  def change
    change_column :marketplace_sales, :date, :datetime, null: false
  end
end
