class ChangeCurrencyColumnsToIntegersOnTrades < ActiveRecord::Migration[6.0]
  def change
    change_column :trades, :scm_spent, :integer
    change_column :trades, :usd_spent, :integer
    change_column :trades, :scm_received, :integer
    change_column :trades, :usd_received, :integer
  end
end
