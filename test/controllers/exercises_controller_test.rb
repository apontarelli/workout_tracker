require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exercises_index_url
    assert_response :success
  end

  test "should get show" do
    get exercises_show_url
    assert_response :success
  end
end
