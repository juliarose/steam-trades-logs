class AddStrangeToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trade_items, :strange, :boolean
  end
end
