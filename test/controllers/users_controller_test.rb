require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should update user" do
    patch user_update_path(@user), params: { user: { name: "Updated Name", email: "updated@example.com", password: @user.password_digest, password_confirmation: @user.password_digest } }
    assert_redirected_to user_account_path
    assert_equal "Account settings updated successfully!", flash[:success]
    @user.reload
    assert_equal "Updated Name", @user.name
    assert_equal "updated@example.com", @user.email
  end

  test "should not update user with invalid params" do
    patch user_update_path(@user), params: { user: { name: "", email: "invalid_email" } }
    assert_template :edit
    assert_equal "Failed to update account settings!", flash[:alert]
    @user.reload
    assert_not_equal "", @user.name
    assert_not_equal "invalid_email", @user.email
  end
end
