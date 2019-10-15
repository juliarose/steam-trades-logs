class AddSteamTradeToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :steam_trade_items, :steam_trade, null: false, foreign_key: true
  end
end
