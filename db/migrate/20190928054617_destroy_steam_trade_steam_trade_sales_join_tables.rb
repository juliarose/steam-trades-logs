class DestroySteamTradeSteamTradeSalesJoinTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :given_items
    drop_table :received_items
  end
end
