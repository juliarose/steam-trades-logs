require 'test_helper'

class MarketplaceSaleItemTest < ActiveSupport::TestCase
  from_json_item = MarketplaceSaleItem.from_json({
      "id": 8670387575,
      "original_id": 6685463400,
      "name": "★Isotope Brick House Minigun (Battle Scarred)",
      "price": 4199,
      "sku": "15055;15;u702;w5;pk55"
  })
  
  test "from_json assetid works" do
    assert from_json_item.assetid == 8670387575
  end
  
  test "from_json skin_name works" do
    assert from_json_item.skin_name == "Brick House"
  end
  
  test "from_json skin_id works" do
    assert from_json_item.skin_id == 55
  end
  
  test "from_json wear_id works" do
    assert from_json_item.wear_id == 5
  end
  
  test "from_json particle_id works" do
    assert from_json_item.particle_id == 702
  end
end
