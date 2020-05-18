require 'test_helper'

class SteamTradeItemTest < ActiveSupport::TestCase
  from_json_item = SteamTradeItem.from_json({
      "id": "7936580379",
      "appid": "440",
      "contextid": "2",
      "market_hash_name": "Refined Metal",
      "assetid": "7936580379",
      "classid": "2674",
      "instanceid": "11040547",
      "amount": "1",
      "missing": false,
      "appdata": {
          "defindex": 5002,
          "quality": 6,
          "tradable": 1,
          "craftable": 1,
          "priceindex": 0
      }
  })
  
  test "particle url works for Kill-a-Watt Bot Dogger" do
    assert !steam_trade_items(:kaw_bot_dogger).particle_url.nil?
  end
  
  test "from_json assetid works" do
    assert from_json_item.assetid == 7936580379
  end
  
  test "from_json defindex works" do
    assert from_json_item.defindex == 5002
  end
  
  test "from_json quality_id works" do
    assert from_json_item.quality_id == 6
  end
end
