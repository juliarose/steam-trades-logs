require "application_system_test_case"

class DetailItemsTest < ApplicationSystemTestCase
  setup do
    @detail_item = detail_items(:one)
  end

  test "visiting the index" do
    visit detail_items_url
    assert_selector "h1", text: "Detail Items"
  end

  test "creating a Detail item" do
    visit detail_items_url
    click_on "New Detail Item"

    fill_in "Appid", with: @detail_item.appid
    fill_in "Assetid", with: @detail_item.assetid
    fill_in "Contextid", with: @detail_item.contextid
    check "Craftable" if @detail_item.craftable
    fill_in "Defindex", with: @detail_item.defindex
    fill_in "Killstreak tier", with: @detail_item.killstreak_tier_id
    fill_in "Skin name", with: @detail_item.skin_name
    fill_in "Wear", with: @detail_item.wear_id
    click_on "Create Detail item"

    assert_text "Detail item was successfully created"
    click_on "Back"
  end

  test "updating a Detail item" do
    visit detail_items_url
    click_on "Edit", match: :first

    fill_in "Appid", with: @detail_item.appid
    fill_in "Assetid", with: @detail_item.assetid
    fill_in "Contextid", with: @detail_item.contextid
    check "Craftable" if @detail_item.craftable
    fill_in "Defindex", with: @detail_item.defindex
    fill_in "Killstreak tier", with: @detail_item.killstreak_tier_id
    fill_in "Skin name", with: @detail_item.skin_name
    fill_in "Wear", with: @detail_item.wear_id
    click_on "Update Detail item"

    assert_text "Detail item was successfully updated"
    click_on "Back"
  end

  test "destroying a Detail item" do
    visit detail_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Detail item was successfully destroyed"
  end
end
