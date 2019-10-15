require 'test_helper'

class MarketplaceSaleItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_sale_item = marketplace_sale_items(:one)
  end

  test "should get index" do
    get marketplace_sale_items_url
    assert_response :success
  end

  test "should get new" do
    get new_marketplace_sale_item_url
    assert_response :success
  end

  test "should create marketplace_sale_item" do
    assert_difference('MarketplaceSaleItem.count') do
      post marketplace_sale_items_url, params: { marketplace_sale_item: { defindex: @marketplace_sale_item.defindex, full_name: @marketplace_sale_item.full_name, full_sku: @marketplace_sale_item.full_sku, item_id: @marketplace_sale_item.item_id, item_name: @marketplace_sale_item.item_name, item_original_id: @marketplace_sale_item.item_original_id, killstreak_tier_id: @marketplace_sale_item.killstreak_tier_id, marketplace_sale_id: @marketplace_sale_item.marketplace_sale_id, particle_id: @marketplace_sale_item.particle_id, price: @marketplace_sale_item.price, quality_id: @marketplace_sale_item.quality_id, skin_name: @marketplace_sale_item.skin_name, sku: @marketplace_sale_item.sku, wear_id: @marketplace_sale_item.wear_id } }
    end

    assert_redirected_to marketplace_sale_item_url(MarketplaceSaleItem.last)
  end

  test "should show marketplace_sale_item" do
    get marketplace_sale_item_url(@marketplace_sale_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_marketplace_sale_item_url(@marketplace_sale_item)
    assert_response :success
  end

  test "should update marketplace_sale_item" do
    patch marketplace_sale_item_url(@marketplace_sale_item), params: { marketplace_sale_item: { defindex: @marketplace_sale_item.defindex, full_name: @marketplace_sale_item.full_name, full_sku: @marketplace_sale_item.full_sku, item_id: @marketplace_sale_item.item_id, item_name: @marketplace_sale_item.item_name, item_original_id: @marketplace_sale_item.item_original_id, killstreak_tier_id: @marketplace_sale_item.killstreak_tier_id, marketplace_sale_id: @marketplace_sale_item.marketplace_sale_id, particle_id: @marketplace_sale_item.particle_id, price: @marketplace_sale_item.price, quality_id: @marketplace_sale_item.quality_id, skin_name: @marketplace_sale_item.skin_name, sku: @marketplace_sale_item.sku, wear_id: @marketplace_sale_item.wear_id } }
    assert_redirected_to marketplace_sale_item_url(@marketplace_sale_item)
  end

  test "should destroy marketplace_sale_item" do
    assert_difference('MarketplaceSaleItem.count', -1) do
      delete marketplace_sale_item_url(@marketplace_sale_item)
    end

    assert_redirected_to marketplace_sale_items_url
  end
end
