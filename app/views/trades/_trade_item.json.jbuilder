json.extract! trade, :id, :assetid, :appid, :contextid, :item_name, :defindex, :craftable, :skin_name, :killstreak_tier_id, :wear_id, :particle_id, :quality_id, :purchased_at, :sold_at, :keys_spent, :scm_spent, :usd_spent, :items_spent, :keys_received, :scm_received, :usd_received, :items_received, :notes, :steamid, :steamid_other, :created_at, :updated_at
json.url trade_url(trade, format: :json)
