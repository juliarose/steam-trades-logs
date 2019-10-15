require "application_system_test_case"

class MarketplaceSaleItemsTest < ApplicationSystemTestCase
  setup do
    @marketplace_sale_item = marketplace_sale_items(:one)
  end

  test "visiting the index" do
    visit marketplace_sale_items_url
    assert_selector "h1", text: "Marketplace Sale Items"
  end

  test "creating a Marketplace sale item" do
    visit marketplace_sale_items_url
    click_on "New Marketplace Sale Item"

    fill_in "Defindex", with: @marketplace_sale_item.defindex
    fill_in "Full name", with: @marketplace_sale_item.full_name
    fill_in "Full sku", with: @marketplace_sale_item.full_sku
    fill_in "Item", with: @marketplace_sale_item.item_id
    fill_in "Item name", with: @marketplace_sale_item.item_name
    fill_in "Item original", with: @marketplace_sale_item.item_original_id
    fill_in "Killstreak tier", with: @marketplace_sale_item.killstreak_tier_id
    fill_in "Marketplace sale", with: @marketplace_sale_item.marketplace_sale_id
    fill_in "Particle", with: @marketplace_sale_item.particle_id
    fill_in "Price", with: @marketplace_sale_item.price
    fill_in "Quality", with: @marketplace_sale_item.quality_id
    fill_in "Skin name", with: @marketplace_sale_item.skin_name
    fill_in "Sku", with: @marketplace_sale_item.sku
    fill_in "Wear", with: @marketplace_sale_item.wear_id
    click_on "Create Marketplace sale item"

    assert_text "Marketplace sale item was successfully created"
    click_on "Back"
  end

  test "updating a Marketplace sale item" do
    visit marketplace_sale_items_url
    click_on "Edit", match: :first

    fill_in "Defindex", with: @marketplace_sale_item.defindex
    fill_in "Full name", with: @marketplace_sale_item.full_name
    fill_in "Full sku", with: @marketplace_sale_item.full_sku
    fill_in "Item", with: @marketplace_sale_item.item_id
    fill_in "Item name", with: @marketplace_sale_item.item_name
    fill_in "Item original", with: @marketplace_sale_item.item_original_id
    fill_in "Killstreak tier", with: @marketplace_sale_item.killstreak_tier_id
    fill_in "Marketplace sale", with: @marketplace_sale_item.marketplace_sale_id
    fill_in "Particle", with: @marketplace_sale_item.particle_id
    fill_in "Price", with: @marketplace_sale_item.price
    fill_in "Quality", with: @marketplace_sale_item.quality_id
    fill_in "Skin name", with: @marketplace_sale_item.skin_name
    fill_in "Sku", with: @marketplace_sale_item.sku
    fill_in "Wear", with: @marketplace_sale_item.wear_id
    click_on "Update Marketplace sale item"

    assert_text "Marketplace sale item was successfully updated"
    click_on "Back"
  end

  test "destroying a Marketplace sale item" do
    visit marketplace_sale_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Marketplace sale item was successfully destroyed"
  end
end
