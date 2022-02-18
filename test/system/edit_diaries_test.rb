require "application_system_test_case"

class EditDiariesTest < ApplicationSystemTestCase

  setup do
    @user = create :confirmed_user
    sign_in(@user)
  end

  teardown do
    @user = nil
  end

  test "should be able to create EntryText" do
    visit edit_diary_url

    fill_in "Title", with: "Sample Entry Text"
    find("#entry-text-button").click
    find("#add-entry-button").click

    page.has_css? "span.title", text: "Sample Entry Text"
    page.has_css? "i.material-icons", text: "insert_chart"
  end

  test "should be able to create EntryCheck" do
    visit edit_diary_url

    fill_in "Title", with: "Sample Entry Check"
    find("#entry-check-button").click
    find("#add-entry-button").click

    page.has_css? "span.title", text: "Sample Entry Check"
    page.has_css? "i.material-icons", text: "check_box"
  end

  test "should be able to create EntryLine" do
    visit edit_diary_url

    fill_in "Title", with: "Sample Entry Line"
    find("#entry-line-button").click
    find("#add-entry-button").click

    page.has_css? "span.title", text: "Sample Entry Line"
    page.has_css? "i.material-icons", text: "short_text"
  end

  test "should be able to update entry" do
    visit edit_diary_url
    first("a.edit").click

    fill_in "Title", with: "Sample Entry"
    find("#entry-check-button").click
    find(".hidden label").click
    find("#save-entry-button").click

    page.has_css? "span.title", text: "Sample Entry"
    page.has_css? "i.material-icons", text: "check_box"
    page.has_css? "div.diary-entry.hidden"
  end

  test "should be able to delete entry" do
    diary_entry = create :diary_entry, title: "Sample Entry"
    visit edit_diary_url
    all("a.edit").last.click

    accept_alert do
      find(".delete label").click
    end

    page.has_no_css? "span.title", text: "Sample Entry"
  end

end
