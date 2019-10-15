require 'test_helper'

class MarketListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market_listing = market_listings(:one)
  end

  test "should get index" do
    get market_listings_url
    assert_response :success
  end

  test "should get new" do
    get new_market_listing_url
    assert_response :success
  end

  test "should create market_listing" do
    assert_difference('MarketListing.count') do
      post market_listings_url, params: { market_listing: { appid: @market_listing.appid, assetid: @market_listing.assetid, background_color: @market_listing.background_color, classid: @market_listing.classid, contextid: @market_listing.contextid, date_acted: @market_listing.date_acted, date_listed: @market_listing.date_listed, icon_url: @market_listing.icon_url, index: @market_listing.index, instanceid: @market_listing.instanceid, is_credit: @market_listing.is_credit, market_hash_name: @market_listing.market_hash_name, market_name: @market_listing.market_name, name: @market_listing.name, name_color: @market_listing.name_color, price: @market_listing.price, seller: @market_listing.seller, transaction_id: @market_listing.transaction_id, transaction_id_high: @market_listing.transaction_id_high } }
    end

    assert_redirected_to market_listing_url(MarketListing.last)
  end

  test "should show market_listing" do
    get market_listing_url(@market_listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_listing_url(@market_listing)
    assert_response :success
  end

  test "should update market_listing" do
    patch market_listing_url(@market_listing), params: { market_listing: { appid: @market_listing.appid, assetid: @market_listing.assetid, background_color: @market_listing.background_color, classid: @market_listing.classid, contextid: @market_listing.contextid, date_acted: @market_listing.date_acted, date_listed: @market_listing.date_listed, icon_url: @market_listing.icon_url, index: @market_listing.index, instanceid: @market_listing.instanceid, is_credit: @market_listing.is_credit, market_hash_name: @market_listing.market_hash_name, market_name: @market_listing.market_name, name: @market_listing.name, name_color: @market_listing.name_color, price: @market_listing.price, seller: @market_listing.seller, transaction_id: @market_listing.transaction_id, transaction_id_high: @market_listing.transaction_id_high } }
    assert_redirected_to market_listing_url(@market_listing)
  end

  test "should destroy market_listing" do
    assert_difference('MarketListing.count', -1) do
      delete market_listing_url(@market_listing)
    end

    assert_redirected_to market_listings_url
  end
end
