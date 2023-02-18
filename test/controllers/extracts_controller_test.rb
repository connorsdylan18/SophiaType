require 'test_helper'

class ExtractsControllerTest < ActionController::TestCase
  def setup
    @extract_params = { extract_title: "Example Extract", extract_text: "This is an example extract text" }
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:extract)
  end

  test "should create extract" do
    assert_difference('Extract.count') do
      post :create, params: { extract: @extract_params }
    end

    assert_redirected_to extract_path(assigns(:extract))
  end
end
