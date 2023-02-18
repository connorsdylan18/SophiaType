class RegistrationsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, params: { user: { email: "test@example.com", password: "Password123", password_confirmation: "Password123" } }
    end

    assert_redirected_to root_path
    assert_equal "Account created successfully", flash[:notice]
  end

  test "should not create user with invalid params" do
    assert_no_difference('User.count') do
      post :create, params: { user: { email: "", password: "password", password_confirmation: "password" } }
    end

    assert_response :unprocessable_entity
    assert_template :new
  end
end
