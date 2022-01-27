require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "should be valid" do
    @user = User.new(email: "testuser@example.com", first_name: "Test", last_name: "User", password: "Password111")
    assert @user.valid?, "is invalid"
  end

  test "first_name should be present" do
    flunk "not implemented"
  end
  
  test "first_name should not be too long" do
    flunk "not implemented"
  end

  test "last_name should be present" do
    flunk "not implemented"
  end
  
  test "last_name should not be too long" do
    flunk "not implemented"
  end

  test "email should be present" do
    flunk "not implemented"
  end
  
  test "email should not be too long" do
    flunk "not implemented"
  end

  test "email should be unique" do
    flunk "not implemented"
  end

  test "email should match the format" do
    flunk "not implemented"
  end

  test "email should be downcased" do
    flunk "not implemented"
  end

  test "password should not be too short or too long" do
    flunk "not implemented"
  end

  test "password should match the format" do
    flunk "not implemented"
  end



  
end