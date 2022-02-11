require "test_helper"

class EditDiaryFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @user = create :confirmed_user
    @diary = create :diary, user: @user
    @diary_entry = @diary.diary_entries.sample
    sign_in(@user)
  end

  teardown do
    sign_out_user
    @user, @diary, @diary_entry = nil, nil, nil
  end

  test "user should be able to see the edit diary page" do
    get edit_diary_url
    assert_response :success
    assert_select "span", "Edit Diary"
    assert_select "div.diary-entry"
  end

  test "should have sample entries on create" do
    DiaryEntry::ENTRY_TYPES.each do |type|
      assert_equal 1, @diary.diary_entries.where(entry_type: type).count
    end
  end

  test "user should be able to create a diary entry" do
    assert_difference("DiaryEntry.count", 1) do
      post diary_entries_url, params: { diary_entry: {
        title: Faker::Lorem.sentence(word_count: 3),
        entry_type: DiaryEntry::ENTRY_TYPES.sample 
      } }
    end

    assert_redirected_to edit_diary_url
  end

  test "user should be able to edit a diary entry" do
    new_title = Faker::Lorem.sentence(word_count: 3)
    new_type = DiaryEntry::ENTRY_TYPES.sample
    patch diary_entry_url(@diary_entry), params: { diary_entry: { title: new_title } }

    assert_redirected_to edit_diary_url
    @diary_entry.reload
    assert_equal new_title, @diary_entry.title
  end

  test "user should be able to delete a diary entry" do
    assert_difference("DiaryEntry.count", -1) do
      delete diary_entry_url(@diary_entry)
    end
  end

  test "user should be able to rearrange entries" do
    # TODO
  end

  test "user should be redirected to signin page when GETting restricted resources if signed out" do
    sign_out_user
    URLS = [
      edit_diary_url,
      edit_diary_entry_url(@diary_entry)]

      URLS.each do |url|
      get url
      assert_redirected_to signin_url
      follow_redirect!
      assert_response :success
    end
  end

  test "user should be redirected to signin page when trying to create diary_entry signed out" do
    sign_out_user
    post diary_entries_url, params: { diary_entry: {
      title: "Title",
      entry_type: DiaryEntry::ENTRY_TYPES.sample } }

    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "user should be redirected to signin page when trying to update diary_entry signed out" do
    sign_out_user
    patch diary_entry_url(@diary_entry), params: { diary_entry: {
      title: "Title",
      entry_type: DiaryEntry::ENTRY_TYPES.sample } }

    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "user should be redirected to signin page when trying to delete diary_entry signed out" do
    sign_out_user
    delete diary_entry_url(@diary_entry)

    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  # TODO: test actual redirection
  test "user should be redirected to edit_diary_url if diary_entry not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get edit_diary_entry_url(DiaryEntry.find(9999999999999999))
    end
    # assert_redirected_to edit_diary_url
    # follow_redirect!
    # assert_response :success
  end

end