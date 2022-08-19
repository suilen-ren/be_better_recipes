require "test_helper"

class User::TipsControllerTest < ActionDispatch::IntegrationTest
  test "should get about_diet" do
    get user_tips_about_diet_url
    assert_response :success
  end
end
