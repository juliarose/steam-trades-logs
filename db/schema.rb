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

ActiveRecord::Schema.define(version: 2021_03_01_010654) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cash_trades", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.date "date"
    t.string "steamid"
    t.string "tradeid"
    t.bigint "steam_trade_id"
    t.string "txid"
    t.string "email"
    t.integer "keys"
    t.integer "usd"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "processor_id"
    t.string "mobile_number"
    t.index ["steam_trade_id"], name: "index_cash_trades_on_steam_trade_id"
  end

  create_table "key_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.float "value"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "market_listings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "transaction_id", null: false
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
    t.date "date_acted", null: false
    t.date "date_listed", null: false
    t.integer "price", null: false
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
    t.boolean "australium"
    t.boolean "strange", default: false, null: false
    t.boolean "craftable", default: false, null: false
    t.index ["quality_id", "is_credit"], name: "market_listings_quality_id_is_credit"
    t.index ["transaction_id"], name: "market_listings_transaction_id"
  end

  create_table "marketplace_sale_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "marketplace_sale_id", null: false
    t.integer "price", null: false
    t.bigint "assetid"
    t.bigint "asset_original_id"
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
    t.integer "skin_id"
    t.boolean "australium", default: false, null: false
    t.boolean "strange", default: false, null: false
    t.boolean "craftable", default: false, null: false
    t.index ["marketplace_sale_id"], name: "index_marketplace_sale_items_on_marketplace_sale_id"
    t.index ["quality_id"], name: "quality_id"
  end

  create_table "marketplace_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "earned_credit", null: false
    t.string "transaction_id", null: false
    t.datetime "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["transaction_id"], name: "marketplace_sales_transaction_id"
  end

  create_table "processors", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
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
    t.integer "appid", limit: 2
    t.integer "contextid", limit: 2
    t.integer "defindex", limit: 3
    t.boolean "craftable", default: false, null: false
    t.string "skin_name"
    t.integer "killstreak_tier_id", limit: 1
    t.integer "wear_id", limit: 1
    t.integer "particle_id", limit: 2
    t.integer "quality_id", limit: 1
    t.string "item_name"
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "steam_trade_id", null: false
    t.boolean "is_their_item"
    t.bigint "classid"
    t.bigint "instanceid"
    t.boolean "australium", default: false, null: false
    t.boolean "strange", default: false, null: false
    t.index ["defindex"], name: "steam_trade_items_defindex"
    t.index ["item_name"], name: "steam_trade_items_item_name"
    t.index ["quality_id", "is_their_item"], name: "steam_trade_items_quality_id_is_their_item"
    t.index ["quality_id"], name: "steam_trade_items_quality_id"
    t.index ["steam_trade_id"], name: "index_steam_trade_items_on_steam_trade_id"
  end

  create_table "steam_trades", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "steamid_other", limit: 17, null: false
    t.datetime "traded_at", null: false
    t.integer "trade_offer_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tradeofferid", null: false
    t.string "steamid", limit: 17, null: false
    t.index ["steamid"], name: "steam_trades_steamid"
    t.index ["steamid_other"], name: "steam_trades_steamid_other"
  end

  create_table "usd_values", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "value"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cash_trades", "steam_trades"
  add_foreign_key "marketplace_sale_items", "marketplace_sales"
  add_foreign_key "steam_trade_items", "steam_trades"
end
