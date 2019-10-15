require 'test_helper'

class DetailItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detail_item = detail_items(:one)
  end

  test "should get index" do
    get detail_items_url
    assert_response :success
  end

  test "should get new" do
    get new_detail_item_url
    assert_response :success
  end

  test "should create detail_item" do
    assert_difference('DetailItem.count') do
      post detail_items_url, params: { detail_item: { appid: @detail_item.appid, assetid: @detail_item.assetid, contextid: @detail_item.contextid, craftable: @detail_item.craftable, defindex: @detail_item.defindex, killstreak_tier_id: @detail_item.killstreak_tier_id, skin_name: @detail_item.skin_name, wear_id: @detail_item.wear_id } }
    end

    assert_redirected_to detail_item_url(DetailItem.last)
  end

  test "should show detail_item" do
    get detail_item_url(@detail_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_detail_item_url(@detail_item)
    assert_response :success
  end

  test "should update detail_item" do
    patch detail_item_url(@detail_item), params: { detail_item: { appid: @detail_item.appid, assetid: @detail_item.assetid, contextid: @detail_item.contextid, craftable: @detail_item.craftable, defindex: @detail_item.defindex, killstreak_tier_id: @detail_item.killstreak_tier_id, skin_name: @detail_item.skin_name, wear_id: @detail_item.wear_id } }
    assert_redirected_to detail_item_url(@detail_item)
  end

  test "should destroy detail_item" do
    assert_difference('DetailItem.count', -1) do
      delete detail_item_url(@detail_item)
    end

    assert_redirected_to detail_items_url
  end
end
