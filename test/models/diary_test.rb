require "test_helper"

class DiaryTest < ActiveSupport::TestCase

  setup do
    @diary = build :diary
  end

  teardown do
    @diary = nil
  end

  test "should be valid" do
    assert @diary.valid?
  end

  test "user should be present" do
    @diary.user = nil
    assert_not @diary.valid?
  end

end