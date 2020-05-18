class ChangeColumnTypesOnSteamTrades < ActiveRecord::Migration[6.0]
  def change
    # steam trades
    change_column :steam_trades, :tradeofferid, :bigint, null: false
    change_column :steam_trades, :steamid, "char(17)", null: false
    change_column :steam_trades, :steamid_other, "char(17)", null: false
  end
end
