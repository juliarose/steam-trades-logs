json.extract! steam_trade_item, :id, :assetid, :appid, :contextid, :defindex, :craftable, :skin_name, :killstreak_tier_id, :wear_id, :created_at, :updated_at
json.url steam_trade_item_url(steam_trade_item, format: :json)
