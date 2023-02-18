require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should not save user as no email present" do
    user = User.new(password: "Password123")
    assert_not user.save, "Saved the user without an email"
  end

  test "Should not save user as invalid email format" do
    user = User.new(email: "invalid_email", password: "Password123")
    assert_not user.save, "Saved the user with an invalid email format"
  end

  test "Should not save user as password less than 8 characters" do
    user = User.new(email: "test@example.com", password: "pass123")
    assert_not user.save, "Saved the user with a password less than 8 characters"
  end

  test "Should not save user as password missing uppercase letter" do
    user = User.new(email: "test@example.com", password: "password123")
    assert_not user.save, "Saved the user with a password missing an uppercase letter"
  end

  test "Should not save user as password missing a number" do
    user = User.new(email: "test@example.com", password: "Password")
    assert_not user.save, "Saved the user with a password missing a number"
  end

  test "Should save user as valid attributes" do
    user = User.new(email: "test@example.com", password: "Password123")
    assert user.save, "Could not save the user with valid attributes"
  end

  test "Picture should be in format as PNG or JPEG" do
    user = User.new
    user.picture.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'text.txt')), 
    filename: 'text.txt', 
    content_type: 'text/plain')
    assert_not user.valid?
    assert_equal ["must be in JPEG or PNG format"], user.errors[:picture]
  end

  test "Picture size should be less than 5MB" do
    user = User.new
    user.picture.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'large_image.png')), 
    filename: 'large_image.png', 
    content_type: 'image/PNG')
    assert_not user.valid?
    assert_equal ["must be less than 5MB"], user.errors[:picture]
  end
end
