require 'test_helper'

class MarketplaceSalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_sale = marketplace_sales(:one)
  end

  test "should get index" do
    get marketplace_sales_url
    assert_response :success
  end

  test "should get new" do
    get new_marketplace_sale_url
    assert_response :success
  end

  test "should create marketplace_sale" do
    assert_difference('MarketplaceSale.count') do
      post marketplace_sales_url, params: { marketplace_sale: { date: @marketplace_sale.date, earned_credit: @marketplace_sale.earned_credit, transaction_id: @marketplace_sale.transaction_id } }
    end

    assert_redirected_to marketplace_sale_url(MarketplaceSale.last)
  end

  test "should show marketplace_sale" do
    get marketplace_sale_url(@marketplace_sale)
    assert_response :success
  end

  test "should get edit" do
    get edit_marketplace_sale_url(@marketplace_sale)
    assert_response :success
  end

  test "should update marketplace_sale" do
    patch marketplace_sale_url(@marketplace_sale), params: { marketplace_sale: { date: @marketplace_sale.date, earned_credit: @marketplace_sale.earned_credit, transaction_id: @marketplace_sale.transaction_id } }
    assert_redirected_to marketplace_sale_url(@marketplace_sale)
  end

  test "should destroy marketplace_sale" do
    assert_difference('MarketplaceSale.count', -1) do
      delete marketplace_sale_url(@marketplace_sale)
    end

    assert_redirected_to marketplace_sales_url
  end
end
