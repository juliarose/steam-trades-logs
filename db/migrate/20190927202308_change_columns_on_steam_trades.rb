class ChangeColumnsOnSteamTrades < ActiveRecord::Migration[6.0]
  def change
    remove_column :steam_trades, :steamid
    remove_column :steam_trades, :notes
  end
end
