require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_session_path
    assert_response :success
  end

  test "should create session" do
    post sign_in_path, params: { email: @user.email, password: 'Password123' }
    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
    assert_equal "Successfully logged in", flash[:notice]
  end

  test "should not create session with invalid credentials" do
    post sign_in_path, params: { email: @user.email, password: 'wrong_password' }
    assert_template :new
    assert_nil session[:user_id]
    assert_equal "Invalid email or password", flash[:alert]
  end

  test "should destroy session" do
    session[:user_id] = @user.id
    delete logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
    assert_equal "Logged out", flash[:notice]
  end
end
