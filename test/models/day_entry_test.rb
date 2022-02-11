require "test_helper"

class DayEntryTest < ActiveSupport::TestCase

  setup do
    @day_entry = build :day_entry
    @day = create :day
  end

  teardown do
    @day_entry, @day = nil, nil, nil
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
    day_entries = @day.day_entries
    assert_equal 1, day_entries.first.diary_entry.sort_order
    assert_equal 2, day_entries.second.diary_entry.sort_order
    assert_equal 3, day_entries.third.diary_entry.sort_order
  end

  test "reverse _ordered scope should reorder by sort_order DESC" do
    day_entries = @day.day_entries.reverse_ordered
    assert_equal 3, day_entries.first.diary_entry.sort_order
    assert_equal 2, day_entries.second.diary_entry.sort_order
    assert_equal 1, day_entries.third.diary_entry.sort_order
  end

end