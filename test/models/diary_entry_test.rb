require "test_helper"

class DiaryEntryTest < ActiveSupport::TestCase

  setup do
    @diary_entry = build :diary_entry
    @diary = create :diary
    @diary_entries = @diary.diary_entries
  end

  teardown do
    @diary_entry, @diary, @diary_entries = nil, nil, nil
  end

  test "should be valid" do
    assert @diary_entry.valid?
  end

  test "should belong to diary" do
    @diary_entry.diary = nil
    assert_not @diary_entry.valid?
  end

  test "title should be present" do
    @diary_entry.title = nil
    assert_not @diary_entry.valid?
  end 

  test "title should contain up to 255 chars" do
    @diary_entry.title = "N" * 256
    assert_not @diary_entry.valid?
  end

  test "title should be unique in scope of diary" do
    diary_2 = create :diary
    diary_entry = @diary_entries.first
    diary_entry_from_the_same_diary = @diary_entries.second
    diary_entry_from_another_diary = create :diary_entry, diary: diary_2

    diary_entry.title = diary_entry_from_another_diary.title
    assert diary_entry.valid?

    diary_entry.title = diary_entry_from_the_same_diary.title
    assert_not diary_entry.valid?
  end

  test "entry type should be present" do
    @diary_entry.entry_type = nil
    assert_not @diary_entry.valid?
  end

  test "entry type should be from predefined ENTRY_TYPES array" do
    assert_includes DiaryEntry::ENTRY_TYPES, @diary_entry.entry_type

    @diary_entry.entry_type = "WrongEntryType"
    assert_not @diary_entry.valid?
  end

  test "sort order should be present and entries should be ordered" do
    diary_entries = DiaryEntry.all
    assert_equal 1, diary_entries.first.sort_order
    assert_equal 2, diary_entries.second.sort_order
    assert_equal 3, diary_entries.third.sort_order
  end

  test "reverse_ordered scope should reverse order" do
    reversed_entries = DiaryEntry.reverse_ordered
    assert_equal 3, reversed_entries.first.sort_order
    assert_equal 2, reversed_entries.second.sort_order
    assert_equal 1, reversed_entries.third.sort_order
  end

end