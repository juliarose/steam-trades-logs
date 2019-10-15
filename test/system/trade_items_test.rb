require "application_system_test_case"

class TradeItemsTest < ApplicationSystemTestCase
  setup do
    @trade_item = trade_items(:one)
  end

  test "visiting the index" do
    visit trade_items_url
    assert_selector "h1", text: "Trade Items"
  end

  test "creating a Trade item" do
    visit trade_items_url
    click_on "New Trade Item"

    fill_in "Appid", with: @trade_item.appid
    fill_in "Assetid", with: @trade_item.assetid
    fill_in "Contextid", with: @trade_item.contextid
    check "Craftable" if @trade_item.craftable
    fill_in "Defindex", with: @trade_item.defindex
    fill_in "Item name", with: @trade_item.item_name
    fill_in "Items received", with: @trade_item.items_received
    fill_in "Items spent", with: @trade_item.items_spent
    fill_in "Keys received", with: @trade_item.keys_received
    fill_in "Keys spent", with: @trade_item.keys_spent
    fill_in "Killstreak tier", with: @trade_item.killstreak_tier_id
    fill_in "Notes", with: @trade_item.notes
    fill_in "Particle", with: @trade_item.particle_id
    fill_in "Purchased at", with: @trade_item.purchased_at
    fill_in "Quality", with: @trade_item.quality_id
    fill_in "Scm received", with: @trade_item.scm_received
    fill_in "Scm spent", with: @trade_item.scm_spent
    fill_in "Skin name", with: @trade_item.skin_name
    fill_in "Sold at", with: @trade_item.sold_at
    fill_in "Steamid", with: @trade_item.steamid
    fill_in "Steamid other", with: @trade_item.steamid_other
    fill_in "Usd received", with: @trade_item.usd_received
    fill_in "Usd spent", with: @trade_item.usd_spent
    fill_in "Wear", with: @trade_item.wear_id
    click_on "Create Trade item"

    assert_text "Trade item was successfully created"
    click_on "Back"
  end

  test "updating a Trade item" do
    visit trade_items_url
    click_on "Edit", match: :first

    fill_in "Appid", with: @trade_item.appid
    fill_in "Assetid", with: @trade_item.assetid
    fill_in "Contextid", with: @trade_item.contextid
    check "Craftable" if @trade_item.craftable
    fill_in "Defindex", with: @trade_item.defindex
    fill_in "Item name", with: @trade_item.item_name
    fill_in "Items received", with: @trade_item.items_received
    fill_in "Items spent", with: @trade_item.items_spent
    fill_in "Keys received", with: @trade_item.keys_received
    fill_in "Keys spent", with: @trade_item.keys_spent
    fill_in "Killstreak tier", with: @trade_item.killstreak_tier_id
    fill_in "Notes", with: @trade_item.notes
    fill_in "Particle", with: @trade_item.particle_id
    fill_in "Purchased at", with: @trade_item.purchased_at
    fill_in "Quality", with: @trade_item.quality_id
    fill_in "Scm received", with: @trade_item.scm_received
    fill_in "Scm spent", with: @trade_item.scm_spent
    fill_in "Skin name", with: @trade_item.skin_name
    fill_in "Sold at", with: @trade_item.sold_at
    fill_in "Steamid", with: @trade_item.steamid
    fill_in "Steamid other", with: @trade_item.steamid_other
    fill_in "Usd received", with: @trade_item.usd_received
    fill_in "Usd spent", with: @trade_item.usd_spent
    fill_in "Wear", with: @trade_item.wear_id
    click_on "Update Trade item"

    assert_text "Trade item was successfully updated"
    click_on "Back"
  end

  test "destroying a Trade item" do
    visit trade_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trade item was successfully destroyed"
  end
end
