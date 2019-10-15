json.extract! market_listing, :id, :transaction_id, :transaction_id_high, :index, :appid, :contextid, :is_credit, :name, :market_name, :market_hash_name, :name_color, :background_color, :assetid, :classid, :instanceid, :icon_url, :date_acted, :date_listed, :price, :seller, :created_at, :updated_at
json.url market_listing_url(market_listing, format: :json)
