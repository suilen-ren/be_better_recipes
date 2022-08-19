require "test_helper"

class User::GoalControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_goal_show_url
    assert_response :success
  end
end
