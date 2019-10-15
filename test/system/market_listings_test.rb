require "application_system_test_case"

class MarketListingsTest < ApplicationSystemTestCase
  setup do
    @market_listing = market_listings(:one)
  end

  test "visiting the index" do
    visit market_listings_url
    assert_selector "h1", text: "Market Listings"
  end

  test "creating a Market listing" do
    visit market_listings_url
    click_on "New Market Listing"

    fill_in "Appid", with: @market_listing.appid
    fill_in "Assetid", with: @market_listing.assetid
    fill_in "Background color", with: @market_listing.background_color
    fill_in "Classid", with: @market_listing.classid
    fill_in "Contextid", with: @market_listing.contextid
    fill_in "Date acted", with: @market_listing.date_acted
    fill_in "Date listed", with: @market_listing.date_listed
    fill_in "Icon url", with: @market_listing.icon_url
    fill_in "Index", with: @market_listing.index
    fill_in "Instanceid", with: @market_listing.instanceid
    check "Is credit" if @market_listing.is_credit
    fill_in "Market hash name", with: @market_listing.market_hash_name
    fill_in "Market name", with: @market_listing.market_name
    fill_in "Name", with: @market_listing.name
    fill_in "Name color", with: @market_listing.name_color
    fill_in "Price", with: @market_listing.price
    fill_in "Seller", with: @market_listing.seller
    fill_in "Transaction", with: @market_listing.transaction_id
    fill_in "Transaction id high", with: @market_listing.transaction_id_high
    click_on "Create Market listing"

    assert_text "Market listing was successfully created"
    click_on "Back"
  end

  test "updating a Market listing" do
    visit market_listings_url
    click_on "Edit", match: :first

    fill_in "Appid", with: @market_listing.appid
    fill_in "Assetid", with: @market_listing.assetid
    fill_in "Background color", with: @market_listing.background_color
    fill_in "Classid", with: @market_listing.classid
    fill_in "Contextid", with: @market_listing.contextid
    fill_in "Date acted", with: @market_listing.date_acted
    fill_in "Date listed", with: @market_listing.date_listed
    fill_in "Icon url", with: @market_listing.icon_url
    fill_in "Index", with: @market_listing.index
    fill_in "Instanceid", with: @market_listing.instanceid
    check "Is credit" if @market_listing.is_credit
    fill_in "Market hash name", with: @market_listing.market_hash_name
    fill_in "Market name", with: @market_listing.market_name
    fill_in "Name", with: @market_listing.name
    fill_in "Name color", with: @market_listing.name_color
    fill_in "Price", with: @market_listing.price
    fill_in "Seller", with: @market_listing.seller
    fill_in "Transaction", with: @market_listing.transaction_id
    fill_in "Transaction id high", with: @market_listing.transaction_id_high
    click_on "Update Market listing"

    assert_text "Market listing was successfully updated"
    click_on "Back"
  end

  test "destroying a Market listing" do
    visit market_listings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Market listing was successfully destroyed"
  end
end
