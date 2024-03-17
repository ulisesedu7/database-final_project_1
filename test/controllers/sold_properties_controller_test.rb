require "test_helper"

class SoldPropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sold_property = sold_properties(:one)
  end

  test "should get index" do
    get sold_properties_url
    assert_response :success
  end

  test "should get new" do
    get new_sold_property_url
    assert_response :success
  end

  test "should create sold_property" do
    assert_difference("SoldProperty.count") do
      post sold_properties_url, params: { sold_property: {  } }
    end

    assert_redirected_to sold_property_url(SoldProperty.last)
  end

  test "should show sold_property" do
    get sold_property_url(@sold_property)
    assert_response :success
  end

  test "should get edit" do
    get edit_sold_property_url(@sold_property)
    assert_response :success
  end

  test "should update sold_property" do
    patch sold_property_url(@sold_property), params: { sold_property: {  } }
    assert_redirected_to sold_property_url(@sold_property)
  end

  test "should destroy sold_property" do
    assert_difference("SoldProperty.count", -1) do
      delete sold_property_url(@sold_property)
    end

    assert_redirected_to sold_properties_url
  end
end
