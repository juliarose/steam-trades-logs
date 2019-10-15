require 'test_helper'

class TradeItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_item = trade_items(:one)
  end

  test "should get index" do
    get trade_items_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_item_url
    assert_response :success
  end

  test "should create trade_item" do
    assert_difference('TradeItem.count') do
      post trade_items_url, params: { trade_item: { appid: @trade_item.appid, assetid: @trade_item.assetid, contextid: @trade_item.contextid, craftable: @trade_item.craftable, defindex: @trade_item.defindex, item_name: @trade_item.item_name, items_received: @trade_item.items_received, items_spent: @trade_item.items_spent, keys_received: @trade_item.keys_received, keys_spent: @trade_item.keys_spent, killstreak_tier_id: @trade_item.killstreak_tier_id, notes: @trade_item.notes, particle_id: @trade_item.particle_id, purchased_at: @trade_item.purchased_at, quality_id: @trade_item.quality_id, scm_received: @trade_item.scm_received, scm_spent: @trade_item.scm_spent, skin_name: @trade_item.skin_name, sold_at: @trade_item.sold_at, steamid: @trade_item.steamid, steamid_other: @trade_item.steamid_other, usd_received: @trade_item.usd_received, usd_spent: @trade_item.usd_spent, wear_id: @trade_item.wear_id } }
    end

    assert_redirected_to trade_item_url(TradeItem.last)
  end

  test "should show trade_item" do
    get trade_item_url(@trade_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_item_url(@trade_item)
    assert_response :success
  end

  test "should update trade_item" do
    patch trade_item_url(@trade_item), params: { trade_item: { appid: @trade_item.appid, assetid: @trade_item.assetid, contextid: @trade_item.contextid, craftable: @trade_item.craftable, defindex: @trade_item.defindex, item_name: @trade_item.item_name, items_received: @trade_item.items_received, items_spent: @trade_item.items_spent, keys_received: @trade_item.keys_received, keys_spent: @trade_item.keys_spent, killstreak_tier_id: @trade_item.killstreak_tier_id, notes: @trade_item.notes, particle_id: @trade_item.particle_id, purchased_at: @trade_item.purchased_at, quality_id: @trade_item.quality_id, scm_received: @trade_item.scm_received, scm_spent: @trade_item.scm_spent, skin_name: @trade_item.skin_name, sold_at: @trade_item.sold_at, steamid: @trade_item.steamid, steamid_other: @trade_item.steamid_other, usd_received: @trade_item.usd_received, usd_spent: @trade_item.usd_spent, wear_id: @trade_item.wear_id } }
    assert_redirected_to trade_item_url(@trade_item)
  end

  test "should destroy trade_item" do
    assert_difference('TradeItem.count', -1) do
      delete trade_item_url(@trade_item)
    end

    assert_redirected_to trade_items_url
  end
end
