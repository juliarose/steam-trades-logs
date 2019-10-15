require "application_system_test_case"

class MarketplaceSalesTest < ApplicationSystemTestCase
  setup do
    @marketplace_sale = marketplace_sales(:one)
  end

  test "visiting the index" do
    visit marketplace_sales_url
    assert_selector "h1", text: "Marketplace Sales"
  end

  test "creating a Marketplace sale" do
    visit marketplace_sales_url
    click_on "New Marketplace Sale"

    fill_in "Date", with: @marketplace_sale.date
    fill_in "Earned credit", with: @marketplace_sale.earned_credit
    fill_in "Transaction", with: @marketplace_sale.transaction_id
    click_on "Create Marketplace sale"

    assert_text "Marketplace sale was successfully created"
    click_on "Back"
  end

  test "updating a Marketplace sale" do
    visit marketplace_sales_url
    click_on "Edit", match: :first

    fill_in "Date", with: @marketplace_sale.date
    fill_in "Earned credit", with: @marketplace_sale.earned_credit
    fill_in "Transaction", with: @marketplace_sale.transaction_id
    click_on "Update Marketplace sale"

    assert_text "Marketplace sale was successfully updated"
    click_on "Back"
  end

  test "destroying a Marketplace sale" do
    visit marketplace_sales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Marketplace sale was successfully destroyed"
  end
end
