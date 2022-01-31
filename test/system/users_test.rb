require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  test "viewing the index signed out" do
    visit root_url
  
    assert_selector "h1", text: "Hello,"
    assert_selector ".user-form"
    assert_selector "a#signup-button"
    assert_selector "a#signin-button"
  end

  test "clicking sign in button shows sign in form" do
    visit root_url

    find('#signin-button').click

    assert_selector "h1", text: "Welcome back!"
  end

  test "clicking sign up button shows sign up page" do
    visit signin_url

    find('#signup-button').click

    assert_selector "h1", text: "Hello,"
  end

  test "successfully signs up" do
    visit root_url
    user = build :user

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Let's go!"

    assert_selector "span", text: "Edit Diary"
  end

end