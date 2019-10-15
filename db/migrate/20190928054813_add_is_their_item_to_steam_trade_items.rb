class AddIsTheirItemToSteamTradeItems < ActiveRecord::Migration[6.0]
  def change
    add_column :steam_trade_items, :is_their_item, :boolean
  end
end
