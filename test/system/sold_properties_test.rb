require "application_system_test_case"

class SoldPropertiesTest < ApplicationSystemTestCase
  setup do
    @sold_property = sold_properties(:one)
  end

  test "visiting the index" do
    visit sold_properties_url
    assert_selector "h1", text: "Sold properties"
  end

  test "should create sold property" do
    visit sold_properties_url
    click_on "New sold property"

    click_on "Create Sold property"

    assert_text "Sold property was successfully created"
    click_on "Back"
  end

  test "should update Sold property" do
    visit sold_property_url(@sold_property)
    click_on "Edit this sold property", match: :first

    click_on "Update Sold property"

    assert_text "Sold property was successfully updated"
    click_on "Back"
  end

  test "should destroy Sold property" do
    visit sold_property_url(@sold_property)
    click_on "Destroy this sold property", match: :first

    assert_text "Sold property was successfully destroyed"
  end
end
