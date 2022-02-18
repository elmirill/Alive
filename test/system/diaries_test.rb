require "application_system_test_case"

class DiariesTest < ApplicationSystemTestCase

  setup do
    @user = create :confirmed_user
    sign_in(@user)
  end

  teardown do
    @user = nil
  end

  test "should be able to open day from the days list" do
    visit days_url
    days_count = all(".card.day").count
    random_day = rand(days_count)
    date = all(".card.day .left")[random_day].text

    all(".card.day a")[random_day].click

    assert_diary_page(date)
  end

  test "should be able to navigate between days" do
    visit today_url

    date = find("span.nav-title").text
    date_yesterday = humanized_date(date.to_date - 1.day)
    
    find("i.material-icons", text: "arrow_back").click
    assert_diary_page(date_yesterday)
    find("i.material-icons", text: "arrow_forward").click
    assert_diary_page(date)
  end

  test "should save entry_text on change" do
    visit today_url
    text = "Hello World!"

    all("trix-editor").first.click.set(text)
    # Capybara doesn't work good with auto-saving forms, so there's a hack.
    sleep 2
    all("trix-editor").first.send_keys(:tab)
    sleep 2

    visit current_url
    assert page.has_css? "trix-editor", text: text
  end

  test "should save entry_check on click" do
    visit today_url

    all(".check-box label").first.click
    visit current_url

    assert find(".check-box input[type=checkbox]", visible: false).checked?
  end

  test "should save entry_check on space key" do
    visit today_url

    all(".check-box label").first.send_keys(:space)
    visit current_url

    assert find(".check-box input[type=checkbox]", visible: false).checked?
  end

  test "should save entry_line on change" do
    visit today_url
    line_text = "123"

    all(".line-text input").first.click.set(line_text)
    sleep 1
    all(".line-text input").first.send_keys(:tab)
    sleep 1

    visit current_url
    assert page.has_field? type: "text", with: line_text
  end

end
