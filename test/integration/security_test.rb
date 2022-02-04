require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do

  end

  teardown do

  end

  test "user_1 shouldn't be able to edit user_2 data" do
    # TODO finish after updating auth to Devise
    user_1 = create :user
    user_1_diary = create :diary, user: user_1
    user_1_day = create :day, diary: user_1_diary
    user_1_diary_entry = user_1_diary.diary_entries.first
    user_1_day_entry = user_1_diary_entry.day_entries.first
    user_2 = create :user

    signin(user_2)
    patch diary_entry_url(user_1_diary_entry), params: { diary_entry: { title: "Hacked!" } }
    user_1_diary_entry.reload

    # assert_not_equal "Hacked!", user_1_diary_entry.title
  end




end