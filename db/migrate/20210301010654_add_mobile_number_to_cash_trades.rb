class AddMobileNumberToCashTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :cash_trades, :mobile_number, :string
  end
end
