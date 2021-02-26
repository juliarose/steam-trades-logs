class ChangeProcessorTypeOnCashTrades < ActiveRecord::Migration[6.0]
  def change
    remove_column :cash_trades, :processor, :string
    add_column :cash_trades, :processor_id, :integer, references: :processor
  end
end
