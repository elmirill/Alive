require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @new_user = build :user
    @existing_user = create :confirmed_user
  end

  teardown do
    @new_user, @existing_user = nil, nil
  end

  test "viewing the index signed out" do
    visit root_url
    assert_selector "h1", text: "Hello,"
    assert_selector ".user-card"
    assert_selector "a#signup-button"
    assert_selector "a#signin-button"
  end

  test "clicking sign in button shows sign in form" do
    visit root_url
    find('#signin-button').click

    assert_signin_page
  end

  test "clicking sign up button shows sign up page" do
    visit signin_url
    find('#signup-button').click

    assert_signup_page
  end

  test "successfully signs up" do
    visit root_url
    fill_in "First Name", with: @new_user.first_name
    fill_in "Last Name", with: @new_user.last_name
    fill_in "Email", with: @new_user.email
    fill_in "Password", with: @new_user.password
    click_on "Let's go!"

    assert_check_email_page
  end

  test "successfully signs in" do
    visit signin_url
    fill_in "Email", with: @existing_user.email
    fill_in "Password", with: @existing_user.password
    click_on "Get me in!"

    assert_today_page
  end

  test "successfully sings out" do
    sign_in(@existing_user)
    visit root_url
    find('#settings-button').click
    click_on "Sign out"

    assert_signin_page
  end

  test "successfully updates data" do
    sign_in(@existing_user)
    visit settings_url
    fill_in "First Name", with: @new_user.first_name
    fill_in "Last Name", with: @new_user.last_name
    fill_in "Current password to confirm changes", with: @existing_user.password
    click_on "Update"

    page.has_field?("First Name", with: @new_user.first_name)
    page.has_field?("Last Name", with: @new_user.last_name)
  end

  test "successfully deletes account" do
    sign_in(@existing_user)
    visit settings_url
    accept_alert do
      click_on "Delete account"
    end

    assert_signin_page
  end

end
