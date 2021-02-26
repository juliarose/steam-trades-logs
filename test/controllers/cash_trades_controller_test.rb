require 'test_helper'

class CashTradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cash_trade = cash_trades(:one)
  end

  test "should get index" do
    get cash_trades_url
    assert_response :success
  end

  test "should get new" do
    get new_cash_trade_url
    assert_response :success
  end

  test "should create cash_trade" do
    assert_difference('CashTrade.count') do
      post cash_trades_url, params: { cash_trade: { date: @cash_trade.date, email: @cash_trade.email, keys: @cash_trade.keys, notes: @cash_trade.notes, processor: @cash_trade.processor, steam_trade_id_id: @cash_trade.steam_trade_id_id, steamid: @cash_trade.steamid, tradeid: @cash_trade.tradeid, txid: @cash_trade.txid, usd: @cash_trade.usd } }
    end

    assert_redirected_to cash_trade_url(CashTrade.last)
  end

  test "should show cash_trade" do
    get cash_trade_url(@cash_trade)
    assert_response :success
  end

  test "should get edit" do
    get edit_cash_trade_url(@cash_trade)
    assert_response :success
  end

  test "should update cash_trade" do
    patch cash_trade_url(@cash_trade), params: { cash_trade: { date: @cash_trade.date, email: @cash_trade.email, keys: @cash_trade.keys, notes: @cash_trade.notes, processor: @cash_trade.processor, steam_trade_id_id: @cash_trade.steam_trade_id_id, steamid: @cash_trade.steamid, tradeid: @cash_trade.tradeid, txid: @cash_trade.txid, usd: @cash_trade.usd } }
    assert_redirected_to cash_trade_url(@cash_trade)
  end

  test "should destroy cash_trade" do
    assert_difference('CashTrade.count', -1) do
      delete cash_trade_url(@cash_trade)
    end

    assert_redirected_to cash_trades_url
  end
end
