require "mobile_system_test_case"

class MobileUsersTest < MobileSystemTestCase

  test "viewing the index signed out" do
    visit root_url
  
    assert_selector "h1", text: "Hello,"
    assert_selector ".user-form"
    assert_selector "a#mobile-nav-button"

    find('#mobile-nav-button').click

    assert_selector "a#signin-button"
    assert_selector "a#signin-button"
  end

  test "clicking sign in button shows sign in form" do
    visit root_url

    find('#mobile-nav-button').click
    find('#signin-button').click

    assert_selector "h1", text: "Welcome back!"
  end

  test "clicking sign up button shows sign up page" do
    visit signin_url

    find('#mobile-nav-button').click
    find('#signup-button').click

    assert_selector "h1", text: "Hello,"
  end

end
