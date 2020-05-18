class AddSteamidToSteamTrades < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trades, :steamid, :string
  end
end
