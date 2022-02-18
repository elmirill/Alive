require "mobile_system_test_case"

class MobileUsersTest < MobileSystemTestCase

  setup do
    # Extra viewport size override for mobile tests to fix Capybara bug
    Capybara.current_session.current_window.resize_to(375, 667)
    @user = create :confirmed_user
  end

  teardown do
    @user = nil
    # Extra viewport size override for mobile tests to fix Capybara bug
    Capybara.current_session.current_window.resize_to(1400, 1400)
  end

  test "should open nav menu" do
    sign_in(@user)
    visit root_url
    find('#mobile-nav-button').click

    assert_selector "a#settings-button"
    assert_selector "a#today-button"
    assert_selector "a#days-button"
    assert_selector "a#edit-diary-button"
    assert_selector "a#about-button"
  end

end
