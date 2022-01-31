require "test_helper"

class DayEntryTest < ActiveSupport::TestCase

  setup do
    @day_entry = build :day_entry
    @day = create :day
    @diary = create :diary
    @diary_entries = create_list :diary_entry, 3, diary: @diary
    @day_entries = []
    @diary_entries.each do |diary_entry|
      day_entry = create :day_entry, day: @day, diary_entry: diary_entry
      @day_entries << day_entry
    end
  end

  teardown do
    @day_entry, @day, @diary, @diary_entries, @day_entries = nil, nil, nil, nil, nil
  end

  test "should be valid" do
    assert @day_entry.valid?
  end

  test "should belong to day" do
    @day_entry.day = nil
    assert_not @day_entry.valid?
  end

  test "should belong to diary_entry" do
    @day_entry.diary_entry = nil
    assert_not @day_entry.valid?
  end

  test "line should contain up to 255 chars" do
    @day_entry.line = "L" * 256
    assert_not @day_entry.valid?
  end

  test "should be ordered by sort_order ASC" do
    day_entries = DayEntry.all
    assert_equal 1, day_entries.first.diary_entry.sort_order
    assert_equal 2, day_entries.second.diary_entry.sort_order
    assert_equal 3, day_entries.third.diary_entry.sort_order
  end

  test "reverse _ordered scope should reorder by sort_order DESC" do
    day_entries = DayEntry.reverse_ordered
    assert_equal 3, day_entries.first.diary_entry.sort_order
    assert_equal 2, day_entries.second.diary_entry.sort_order
    assert_equal 1, day_entries.third.diary_entry.sort_order
  end

end