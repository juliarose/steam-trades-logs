require "application_system_test_case"

class KeyValuesTest < ApplicationSystemTestCase
  setup do
    @key_value = key_values(:one)
  end

  test "visiting the index" do
    visit key_values_url
    assert_selector "h1", text: "Key Values"
  end

  test "creating a Key value" do
    visit key_values_url
    click_on "New Key Value"

    fill_in "Date", with: @key_value.date
    fill_in "Value", with: @key_value.value
    click_on "Create Key value"

    assert_text "Key value was successfully created"
    click_on "Back"
  end

  test "updating a Key value" do
    visit key_values_url
    click_on "Edit", match: :first

    fill_in "Date", with: @key_value.date
    fill_in "Value", with: @key_value.value
    click_on "Update Key value"

    assert_text "Key value was successfully updated"
    click_on "Back"
  end

  test "destroying a Key value" do
    visit key_values_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Key value was successfully destroyed"
  end
end
