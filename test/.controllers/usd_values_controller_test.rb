require 'test_helper'

class UsdValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_user = users(:one)
    @usd_value = usd_values(:one)
  end

  test "should get index" do
    get usd_values_url
    assert_response :success
  end

  test "should get new" do
    get new_usd_value_url
    assert_response :success
  end

  test "should create usd_value" do
    assert_difference('UsdValue.count') do
      post usd_values_url, params: { usd_value: { date: @usd_value.date, value: @usd_value.value } }
    end

    assert_redirected_to usd_value_url(UsdValue.last)
  end

  test "should show usd_value" do
    get usd_value_url(@usd_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_usd_value_url(@usd_value)
    assert_response :success
  end

  test "should update usd_value" do
    patch usd_value_url(@usd_value), params: { usd_value: { date: @usd_value.date, value: @usd_value.value } }
    assert_redirected_to usd_value_url(@usd_value)
  end

  test "should destroy usd_value" do
    assert_difference('UsdValue.count', -1) do
      delete usd_value_url(@usd_value)
    end

    assert_redirected_to usd_values_url
  end
end
