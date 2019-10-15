# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_28_093003) do

  create_table "key_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.float "value"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "market_listings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "transaction_id"
    t.string "transaction_id_high"
    t.integer "index"
    t.integer "appid"
    t.integer "contextid"
    t.boolean "is_credit"
    t.string "name", collation: "utf8mb4_general_ci"
    t.string "market_name"
    t.string "market_hash_name"
    t.string "name_color"
    t.string "background_color"
    t.bigint "assetid"
    t.bigint "classid"
    t.bigint "instanceid"
    t.text "icon_url", size: :medium
    t.date "date_acted"
    t.date "date_listed"
    t.integer "price"
    t.string "seller"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "defindex"
    t.integer "particle_id"
    t.string "full_name"
    t.integer "quality_id"
    t.integer "wear_id"
    t.integer "killstreak_tier_id"
    t.string "transaction_id_low"
    t.string "skin_name"
    t.string "item_name"
  end

  create_table "marketplace_sale_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "marketplace_sale_id", null: false
    t.integer "price"
    t.bigint "item_id"
    t.bigint "item_original_id"
    t.string "full_name"
    t.integer "defindex"
    t.integer "particle_id"
    t.integer "quality_id"
    t.integer "killstreak_tier_id"
    t.string "skin_name"
    t.string "item_name"
    t.integer "wear_id"
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_sku"
    t.index ["marketplace_sale_id"], name: "index_marketplace_sale_items_on_marketplace_sale_id"
  end

  create_table "marketplace_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "earned_credit"
    t.string "transaction_id"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scm_values", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steam_trade_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "assetid"
    t.integer "appid"
    t.integer "contextid"
    t.integer "defindex"
    t.boolean "craftable"
    t.string "skin_name"
    t.integer "killstreak_tier_id"
    t.integer "wear_id"
    t.integer "particle_id"
    t.integer "quality_id"
    t.string "item_name"
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "steam_trade_id", null: false
    t.boolean "is_their_item"
    t.index ["steam_trade_id"], name: "index_steam_trade_items_on_steam_trade_id"
  end

  create_table "steam_trades", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "steamid_other"
    t.datetime "traded_at"
    t.integer "trade_offer_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trades", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "assetid"
    t.integer "appid"
    t.integer "contextid"
    t.string "item_name"
    t.integer "defindex"
    t.boolean "craftable"
    t.string "skin_name"
    t.integer "killstreak_tier_id"
    t.integer "wear_id"
    t.integer "particle_id"
    t.integer "quality_id"
    t.date "purchased_at"
    t.date "sold_at"
    t.decimal "keys_spent", precision: 13, scale: 2
    t.integer "scm_spent"
    t.integer "usd_spent"
    t.decimal "items_spent", precision: 13, scale: 2
    t.decimal "keys_received", precision: 13, scale: 2
    t.integer "scm_received"
    t.integer "usd_received"
    t.decimal "items_received", precision: 13, scale: 2
    t.text "notes", collation: "utf8mb4_unicode_ci"
    t.string "steamid"
    t.string "steamid_other"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.bigint "purchase_steam_trade_id"
    t.string "purchase_marketplace_purchase_id"
    t.string "purchase_market_listing_id"
    t.bigint "sale_steam_trade_id"
    t.string "sale_marketplace_sale_id"
    t.string "sale_market_listing_id"
  end

  create_table "usd_values", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "marketplace_sale_items", "marketplace_sales"
  add_foreign_key "steam_trade_items", "steam_trades"
end
