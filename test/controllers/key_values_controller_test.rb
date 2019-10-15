require 'test_helper'

class KeyValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @key_value = key_values(:one)
  end

  test "should get index" do
    get key_values_url
    assert_response :success
  end

  test "should get new" do
    get new_key_value_url
    assert_response :success
  end

  test "should create key_value" do
    assert_difference('KeyValue.count') do
      post key_values_url, params: { key_value: { date: @key_value.date, value: @key_value.value } }
    end

    assert_redirected_to key_value_url(KeyValue.last)
  end

  test "should show key_value" do
    get key_value_url(@key_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_key_value_url(@key_value)
    assert_response :success
  end

  test "should update key_value" do
    patch key_value_url(@key_value), params: { key_value: { date: @key_value.date, value: @key_value.value } }
    assert_redirected_to key_value_url(@key_value)
  end

  test "should destroy key_value" do
    assert_difference('KeyValue.count', -1) do
      delete key_value_url(@key_value)
    end

    assert_redirected_to key_values_url
  end
end
