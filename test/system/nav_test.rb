require "application_system_test_case"

class NavTest < ApplicationSystemTestCase

  setup do
    @user = create :confirmed_user
  end

  teardown do
    @user = nil
  end

  test "should open settings page" do
    sign_in(@user)
    visit root_url
    find('#settings-button').click
    assert_settings_page
  end

  test "should open today page" do
    sign_in(@user)
    visit root_url
    find('#today-button').click
    assert_today_page
  end

  test "should open diary index page" do
    sign_in(@user)
    visit root_url
    find('#days-button').click
    assert_diary_index_page
  end

  test "should open edit diary page" do
    sign_in(@user)
    visit root_url
    find('#edit-diary-button').click
    assert_edit_diary_page
  end

  test "should open about page" do
    sign_in(@user)
    visit root_url
    find('#about-button').click
    assert_about_page
  end

end
