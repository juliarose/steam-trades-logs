require 'test_helper'

class ScmValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scm_value = scm_values(:one)
  end

  test "should get index" do
    get scm_values_url
    assert_response :success
  end

  test "should get new" do
    get new_scm_value_url
    assert_response :success
  end

  test "should create scm_value" do
    assert_difference('ScmValue.count') do
      post scm_values_url, params: { scm_value: { date: @scm_value.date, value: @scm_value.value } }
    end

    assert_redirected_to scm_value_url(ScmValue.last)
  end

  test "should show scm_value" do
    get scm_value_url(@scm_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_scm_value_url(@scm_value)
    assert_response :success
  end

  test "should update scm_value" do
    patch scm_value_url(@scm_value), params: { scm_value: { date: @scm_value.date, value: @scm_value.value } }
    assert_redirected_to scm_value_url(@scm_value)
  end

  test "should destroy scm_value" do
    assert_difference('ScmValue.count', -1) do
      delete scm_value_url(@scm_value)
    end

    assert_redirected_to scm_values_url
  end
end
