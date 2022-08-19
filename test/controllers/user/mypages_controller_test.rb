require "test_helper"

class User::MypagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_mypages_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_mypages_edit_url
    assert_response :success
  end

  test "should get recipes" do
    get user_mypages_recipes_url
    assert_response :success
  end

  test "should get confirm" do
    get user_mypages_confirm_url
    assert_response :success
  end
end
