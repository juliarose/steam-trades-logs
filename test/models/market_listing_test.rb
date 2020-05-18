require 'test_helper'

class MarketListingTest < ActiveSupport::TestCase
  from_json_item = MarketListing.from_json({
      "transaction_id": "2588949021217327633-2588949021217327634",
      "appid": "440",
      "contextid": "2",
      "classid": "3432274183",
      "instanceid": "342552586",
      "index": 405210,
      "price": 2760,
      "is_credit": 0,
      "name": "Unusual Dancing Doe",
      "market_name": "Unusual Dancing Doe",
      "market_hash_name": "Unusual Dancing Doe",
      "name_color": "8650AC",
      "background_color": "3C352E",
      "icon": "fWFc82js0fmoRAP-qOIPu5THSWqfSmTELLqcUywGkijVjZULUrsm1j-9xgEYeQpABCTmuTZAgcbhMvaDDd8Mmsgy4N4NgTIyyAcsMrDhMWRkcVaaWPYIDPBprQvuUHcx6pMyB4-y9esCLVnsqsKYZF2DuSkf",
      "date_acted": "2020-04-25T12:00:00.000Z",
      "date_listed": "2020-04-24T12:00:00.000Z",
      "icon_url": "fWFc82js0fmoRAP-qOIPu5THSWqfSmTELLqcUywGkijVjZULUrsm1j-9xgEYeQpABCTmuTZAgcbhMvaDDd8Mmsgy4N4NgTIyyAcsMrDhMWRkcVaaWPYIDPBprQvuUHcx6pMyB4-y9esCLVnsqsKYZF2DuSkf",
      "icon_url_large": "fWFc82js0fmoRAP-qOIPu5THSWqfSmTELLqcUywGkijVjZULUrsm1j-9xgEYeQpABCTmuTZAgcbhMvaDDd8Mmsgy4N4NgTIyyAcsMrDhMWRkcVaaWPYIDPBprQvuUHcx6pMyB4-y9esCLVnsqsKYZF2DuSkf",
      "icon_drag_url": "",
      "type": "Level 1 Bandana",
      "tradable": "1",
      "marketable": "1",
      "commodity": "0",
      "market_tradable_restriction": "7",
      "market_marketable_restriction": "0",
      "date": "2020-04-25T12:00:00.000Z",
      "particle_id": 30,
      "defindex": 31045,
      "quality_id": 5,
      "full_name": "Blizzardy Storm Dancing Doe"
  })
  
  test "from_json particle_id works" do
    assert from_json_item.particle_id == 30
  end
  
  test "from_json item_name works" do
    assert from_json_item.item_name == "Dancing Doe"
  end
  
  test "from_json defindex works" do
    assert from_json_item.defindex == 31045
  end
  
  test "from_json price works" do
    assert from_json_item.price == 2760
  end
end
