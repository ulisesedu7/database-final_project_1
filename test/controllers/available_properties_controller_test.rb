require "test_helper"

class AvailablePropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @available_property = available_properties(:one)
  end

  test "should get index" do
    get available_properties_url
    assert_response :success
  end

  test "should get new" do
    get new_available_property_url
    assert_response :success
  end

  test "should create available_property" do
    assert_difference("AvailableProperty.count") do
      post available_properties_url, params: { available_property: {  } }
    end

    assert_redirected_to available_property_url(AvailableProperty.last)
  end

  test "should show available_property" do
    get available_property_url(@available_property)
    assert_response :success
  end

  test "should get edit" do
    get edit_available_property_url(@available_property)
    assert_response :success
  end

  test "should update available_property" do
    patch available_property_url(@available_property), params: { available_property: {  } }
    assert_redirected_to available_property_url(@available_property)
  end

  test "should destroy available_property" do
    assert_difference("AvailableProperty.count", -1) do
      delete available_property_url(@available_property)
    end

    assert_redirected_to available_properties_url
  end
end
