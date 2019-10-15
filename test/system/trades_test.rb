require "application_system_test_case"

class TradesTest < ApplicationSystemTestCase
  setup do
    @trade = trades(:one)
  end

  test "visiting the index" do
    visit trades_url
    assert_selector "h1", text: "Trades"
  end

  test "creating a Trade" do
    visit trades_url
    click_on "New Trade"

    fill_in "Notes", with: @trade.notes
    fill_in "Steamid", with: @trade.steamid
    fill_in "Steamid other", with: @trade.steamid_other
    fill_in "Trade offer state", with: @trade.trade_offer_state
    fill_in "Traded at", with: @trade.traded_at
    click_on "Create Trade"

    assert_text "Trade was successfully created"
    click_on "Back"
  end

  test "updating a Trade" do
    visit trades_url
    click_on "Edit", match: :first

    fill_in "Notes", with: @trade.notes
    fill_in "Steamid", with: @trade.steamid
    fill_in "Steamid other", with: @trade.steamid_other
    fill_in "Trade offer state", with: @trade.trade_offer_state
    fill_in "Traded at", with: @trade.traded_at
    click_on "Update Trade"

    assert_text "Trade was successfully updated"
    click_on "Back"
  end

  test "destroying a Trade" do
    visit trades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trade was successfully destroyed"
  end
end
