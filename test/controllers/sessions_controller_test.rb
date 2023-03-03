require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: "test@test.com", password: "A1password", password_confirmation: "A1password")
  end

  test "should get new" do
    get new_session_path
    assert_response :success
  end

  test "should create session" do
    post sign_in_path, params: { email: @user.email, password: 'A1password' }
    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
    assert_equal "Successfully logged in", flash[:notice]
  end

  test "should not create session with invalid email" do
    post sign_in_path, params: { email: "invalid@example.com", password: 'A1password' }
    assert_redirected_to root_path 
    assert_equal "Invalid email or password", flash[:alert]
    assert_nil session[:user_id]
  end

  test "should not create session with invalid password" do
    post sign_in_path, params: { email: @user.email, password: 'invalid' }
    assert_redirected_to root_path
    assert_equal "Invalid email or password", flash[:alert]
    assert_nil session[:user_id]
  end

  test "should destroy session" do
    delete logout_path  
    assert_redirected_to root_path
    assert_equal "Logged out", flash[:notice]
    assert_nil session[:user_id]
  end
end
