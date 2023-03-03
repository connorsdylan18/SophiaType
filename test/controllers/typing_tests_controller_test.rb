require 'test_helper'

class TypingTestsControllerTest < ActionController::TestCase
  test "should get index with quote mode and small size" do
    get :index, params: { mode: "quote", size: "Small" }
    assert_response :success
    assert_not_nil assigns(:text)
    assert assigns(:text).split.size <= 25
  end

  test "should get index with words mode and medium size" do
    get :index, params: { mode: "words", size: "Medium" }
    assert_response :success
    assert_not_nil assigns(:text)
    assert assigns(:text).split.size <= 50
  end

  test "should get index with timed mode" do
    get :index, params: { mode: "timed", size: "" }
    assert_response :success
    assert_not_nil assigns(:text)
  end
end
