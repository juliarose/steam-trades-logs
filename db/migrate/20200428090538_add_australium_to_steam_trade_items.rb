class AddAustraliumToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trade_items, :australium, :boolean
  end
end
