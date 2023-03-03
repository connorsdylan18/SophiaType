require "test_helper"

class ResultsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @valid_params = { result: { user_id: @user.id, time: 60, accuracy: 98, netWPM: 60, grossWPM: 70 } }
    @invalid_params = { result: { user_id: @user.id } }
  end

  test "should create result with valid parameters" do
    post :create, params: @valid_params, format: :json
    assert_response :created
    assert_equal @user.id, JSON.parse(response.body)["user_id"]
  end

  test "should not create result with invalid parameters" do
    post :create, params: @invalid_params, format: :json
    assert_response :unprocessable_entity
  end
end
