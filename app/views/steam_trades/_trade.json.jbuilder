json.extract! steam_trade, :id, :steamid, :steamid_other, :traded_at, :trade_offer_state, :notes, :created_at, :updated_at
json.url steam_trade_url(steam_trade, format: :json)
