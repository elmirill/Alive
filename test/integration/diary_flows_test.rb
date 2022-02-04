require "test_helper"

class DiaryFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @user = create :user
    @diary = create :diary, user: @user
    @day = create :day, diary: @diary
    @diary_entry = @diary.diary_entries.sample
    @day_entry = @diary_entry.day_entries.sample
    signin(@user)
  end

  teardown do
    signout
    @user, @diary, @day, @diary_entry, @day_entry = nil, nil, nil
  end

  test "user should be able to see the days page with its data" do
    get days_url
    @diary.reload
    first_date = @diary.days.first.date
    last_date = @diary.days.last.date
    
    assert_response :success
    assert_select "div.day", (7..100)
    assert_select "div.left", humanized_date(first_date)
    assert_select "div.right", weekday(first_date)
    assert_select "div.left", humanized_date(last_date)
    assert_select "div.right", weekday(last_date)
  end

  test "user should be able to see today page with its data" do
    get today_url

    assert_response :success
    assert_select "div.day-entry.entry-text"
    assert_select "div.day-entry.entry-line"
    assert_select "div.day-entry.entry-check"
  end

  test "user should be able to see the specific page with its data" do
    get days_url # to create days
    @diary.reload
    date = @diary.days.sample.date.to_date
    get day_url(date)

    assert_response :success
    assert_select "div.day-entry.entry-text"
    assert_select "div.day-entry.entry-line"
    assert_select "div.day-entry.entry-check"
  end

  test "user should be able to edit day_entry" do
    line_data = Faker::Number.number(digits: 2).to_s
    check_data = true
    rich_text_data = Faker::Lorem.sentence(word_count: 10)
    patch day_entry_url(@day_entry), params: { day_entry: { 
      line: line_data,
      check: check_data,
      rich_text: rich_text_data } }
    @day_entry.reload

    assert_equal line_data, @day_entry.line
    assert_equal check_data, @day_entry.check
    assert_match /#{rich_text_data}/, @day_entry.rich_text.body.to_s
  end

  test "user should be redirected to signin page when GETting restricted resources if signed out" do
    signout
    URLS = [
      today_url,
      days_url,
      day_url(DateTime.current.to_date)]

      URLS.each do |url|
      get url
      assert_redirected_to signin_url
      follow_redirect!
      assert_response :success
    end
  end

  test "user should be redirected to signin page when trying to update diary_entry signed out" do
    signout
    patch day_entry_url(@day_entry), params: { day_entry: {
      line: "Title" } }

    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

end