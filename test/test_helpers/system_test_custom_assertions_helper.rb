module SystemTestCustomAssertionsHelper
  def assert_signin_page
    assert_selector "main#signin"
    assert page.has_field?("Email", type: "email")
    assert page.has_field?("Password", type: "password")
  end

  def assert_signup_page
    assert_selector "main#signup"
    assert_selector "h1", text: "Hello"
    assert page.has_field?("First Name", type: "text")
    assert page.has_field?("Last Name", type: "text")
    assert page.has_field?("Email", type: "email")
    assert page.has_field?("Password", type: "password")
  end

  def assert_check_email_page
    assert_selector "main#check-email"
    assert page.has_css? "h1", text: "Awesome!"
  end

  def assert_today_page
    assert_selector "main#diary"
    assert page.has_css? "span.nav-title", text: humanized_date(DateTime.current)
    assert page.has_css? "div.day-entry"
  end

  def assert_diary_page(date)
    assert_selector "main#diary"
    assert page.has_css? "span.nav-title", text: date
    assert page.has_css? "div.day-entry"
  end

  def assert_diary_index_page
    assert_selector "main#diary-index"
    assert_selector "div.current-day"
  end

  def assert_edit_diary_page
    assert page.has_css? "span.nav-title", text: "Edit Diary"
    assert_selector "div.diary-entries"
    assert_selector "input#diary_entry_title"
  end

  def assert_about_page
    assert_selector "main#about"
  end

  def assert_settings_page
    assert page.has_css? "span.nav-title", text: "Settings"
    assert page.has_field? "First Name", type: "text"
    assert page.has_field? "Last Name", type: "text"
    assert page.has_field? "Email", type: "email"
    assert page.has_field? "Password", type: "password"
    assert page.has_field? "Current password to confirm changes", type: "password"
  end
end