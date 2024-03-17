require "application_system_test_case"

class AvailablePropertiesTest < ApplicationSystemTestCase
  setup do
    @available_property = available_properties(:one)
  end

  test "visiting the index" do
    visit available_properties_url
    assert_selector "h1", text: "Available properties"
  end

  test "should create available property" do
    visit available_properties_url
    click_on "New available property"

    click_on "Create Available property"

    assert_text "Available property was successfully created"
    click_on "Back"
  end

  test "should update Available property" do
    visit available_property_url(@available_property)
    click_on "Edit this available property", match: :first

    click_on "Update Available property"

    assert_text "Available property was successfully updated"
    click_on "Back"
  end

  test "should destroy Available property" do
    visit available_property_url(@available_property)
    click_on "Destroy this available property", match: :first

    assert_text "Available property was successfully destroyed"
  end
end
