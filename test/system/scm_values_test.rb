require "application_system_test_case"

class ScmValuesTest < ApplicationSystemTestCase
  setup do
    @scm_value = scm_values(:one)
  end

  test "visiting the index" do
    visit scm_values_url
    assert_selector "h1", text: "Scm Values"
  end

  test "creating a Scm value" do
    visit scm_values_url
    click_on "New Scm Value"

    fill_in "Date", with: @scm_value.date
    fill_in "Value", with: @scm_value.value
    click_on "Create Scm value"

    assert_text "Scm value was successfully created"
    click_on "Back"
  end

  test "updating a Scm value" do
    visit scm_values_url
    click_on "Edit", match: :first

    fill_in "Date", with: @scm_value.date
    fill_in "Value", with: @scm_value.value
    click_on "Update Scm value"

    assert_text "Scm value was successfully updated"
    click_on "Back"
  end

  test "destroying a Scm value" do
    visit scm_values_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Scm value was successfully destroyed"
  end
end
