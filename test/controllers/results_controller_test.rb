require "test_helper"

class ResultsControllerTest < ActionController::TestCase
  test "should create a new result as params are valid" do
    user = users(:one)
    assert_difference("Result.count") do
      post :create, params: { result: { user_id: user.id, time: 3, accuracy: 95, netWPM: 50, grossWPM: 60 } }, format: :json
    end
    assert_response :created
    assert_not_nil assigns(:result)
  end

  test "should not create a new result as params are invalid" do
    user = users(:one)
    assert_no_difference("Result.count") do
      post :create, params: { result: { user_id: user.id, time: 3, accuracy: 95, netWPM: nil, grossWPM: 60 } }, format: :json
    end
    assert_response :unprocessable_entity
  end

  test "should not create a new result as user_id is missing" do
    assert_no_difference("Result.count") do
      post :create, params: { result: { time: 100, accuracy: 95, netWPM: 50, grossWPM: 60 } }, format: :json
    end
    assert_response :unprocessable_entity
  end
end
