require "application_system_test_case"

class CashTradesTest < ApplicationSystemTestCase
  setup do
    @cash_trade = cash_trades(:one)
  end

  test "visiting the index" do
    visit cash_trades_url
    assert_selector "h1", text: "Cash Trades"
  end

  test "creating a Cash trade" do
    visit cash_trades_url
    click_on "New Cash Trade"

    fill_in "Date", with: @cash_trade.date
    fill_in "Email", with: @cash_trade.email
    fill_in "Keys", with: @cash_trade.keys
    fill_in "Notes", with: @cash_trade.notes
    fill_in "Processor", with: @cash_trade.processor
    fill_in "Steam trade id", with: @cash_trade.steam_trade_id_id
    fill_in "Steamid", with: @cash_trade.steamid
    fill_in "Tradeid", with: @cash_trade.tradeid
    fill_in "Txid", with: @cash_trade.txid
    fill_in "Usd", with: @cash_trade.usd
    click_on "Create Cash trade"

    assert_text "Cash trade was successfully created"
    click_on "Back"
  end

  test "updating a Cash trade" do
    visit cash_trades_url
    click_on "Edit", match: :first

    fill_in "Date", with: @cash_trade.date
    fill_in "Email", with: @cash_trade.email
    fill_in "Keys", with: @cash_trade.keys
    fill_in "Notes", with: @cash_trade.notes
    fill_in "Processor", with: @cash_trade.processor
    fill_in "Steam trade id", with: @cash_trade.steam_trade_id_id
    fill_in "Steamid", with: @cash_trade.steamid
    fill_in "Tradeid", with: @cash_trade.tradeid
    fill_in "Txid", with: @cash_trade.txid
    fill_in "Usd", with: @cash_trade.usd
    click_on "Update Cash trade"

    assert_text "Cash trade was successfully updated"
    click_on "Back"
  end

  test "destroying a Cash trade" do
    visit cash_trades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cash trade was successfully destroyed"
  end
end
