require "application_system_test_case"

class UsdValuesTest < ApplicationSystemTestCase
  setup do
    @usd_value = usd_values(:one)
  end

  test "visiting the index" do
    visit usd_values_url
    assert_selector "h1", text: "Usd Values"
  end

  test "creating a Usd value" do
    visit usd_values_url
    click_on "New Usd Value"

    fill_in "Date", with: @usd_value.date
    fill_in "Value", with: @usd_value.value
    click_on "Create Usd value"

    assert_text "Usd value was successfully created"
    click_on "Back"
  end

  test "updating a Usd value" do
    visit usd_values_url
    click_on "Edit", match: :first

    fill_in "Date", with: @usd_value.date
    fill_in "Value", with: @usd_value.value
    click_on "Update Usd value"

    assert_text "Usd value was successfully updated"
    click_on "Back"
  end

  test "destroying a Usd value" do
    visit usd_values_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Usd value was successfully destroyed"
  end
end
