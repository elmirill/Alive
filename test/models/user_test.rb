require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do
    @user = build :user
  end

  teardown do
    @user = nil
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first_name should be present" do
    @user.first_name = nil
    assert_not @user.valid?
  end 

  test "first_name should contain up to 100 chars" do
    @user.first_name = "N" * 101
    assert_not @user.valid?
  end

  test "last_name should be present" do
    @user.last_name = nil
    assert_not @user.valid?
  end 

  test "last_name should contain up to 100 chars" do
    @user.last_name = "N" * 101
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?
  end
  
  test "email should contain up to 255 chars" do
    @user.last_name = "N" * 256
    assert_not @user.valid?
  end

  test "email should be unique" do
    email = "testuser@example.com"
    user_2 = create :user, email: email
    @user.email = email
    assert_not @user.valid?
  end

  test "email should match the format" do
    @user.email = "user/email.com"
    assert_not @user.valid?
  end

  test "email should be downcased" do
    user = create :user, email: "TESTUSER@example.COM"
    assert_equal "testuser@example.com", user.email
  end

  test "password should contain 8 or more chars" do
    @user.password = "Pass111"
    assert_not @user.valid?
  end

  test "password should contain up to 255 chars" do
    @user.password = "Pass111" * 37
    assert_not @user.valid?
  end

  test "password should match the format" do
    @user.password = "password" * 2
    assert_not @user.valid?
  end
  
end