class AddTradeidToSteamTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trades, :tradeid, :string
  end
end
