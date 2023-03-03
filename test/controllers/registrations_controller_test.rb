require "test_helper"

class RegistrationsControllerTest < ActionController::TestCase
  test "should create user with valid params" do
    assert_difference('User.count') do
      post :create, params: { user: { email: 'test@example.com', password: 'A1password', password_confirmation: 'A1password' } }
    end

    assert_redirected_to root_path 
    assert_equal "Account created successfully", flash[:notice]
    assert_equal assigns(:user).id, session[:user_id]
  end

  test "should not create user with invalid password format" do
    assert_no_difference('User.count') do
      post :create, params: { user: { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
    end

    assert_response :unprocessable_entity
    assert_template :new
  end

  test "should not create user with mismatching password and confirmation" do
    assert_no_difference("User.count") do 
      post :create, params: { user: { email: "test@example.com", password: "password", password_confirmation: "not password "} }
    end

    assert_response :unprocessable_entity
    assert_template :new 
  end

  test "should not create user with invalid email format" do 
    assert_no_difference("User.count") do 
      post :create, params: { user: {email: "bademail.com", password: "A1password", password_confirmation: "A1password"}}
    end 

    assert_response :unprocessable_entity 
    assert_template :new 
  end
end

