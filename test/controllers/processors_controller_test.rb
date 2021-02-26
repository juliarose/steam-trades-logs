require 'test_helper'

class ProcessorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @processor = processors(:one)
  end

  test "should get index" do
    get processors_url
    assert_response :success
  end

  test "should get new" do
    get new_processor_url
    assert_response :success
  end

  test "should create processor" do
    assert_difference('Processor.count') do
      post processors_url, params: { processor: { name: @processor.name } }
    end

    assert_redirected_to processor_url(Processor.last)
  end

  test "should show processor" do
    get processor_url(@processor)
    assert_response :success
  end

  test "should get edit" do
    get edit_processor_url(@processor)
    assert_response :success
  end

  test "should update processor" do
    patch processor_url(@processor), params: { processor: { name: @processor.name } }
    assert_redirected_to processor_url(@processor)
  end

  test "should destroy processor" do
    assert_difference('Processor.count', -1) do
      delete processor_url(@processor)
    end

    assert_redirected_to processors_url
  end
end
