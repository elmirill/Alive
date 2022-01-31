require "test_helper"

class DayTest < ActiveSupport::TestCase

  setup do
    @diary = create :diary
    @days = create_list(:day, 7, diary: @diary)
    @day = build :day
  end

  teardown do
    @days = nil
    @day = nil
  end

  test "should be valid" do
    assert @day.valid?
  end

  test "should belong to diary" do
    @day.diary = nil
    assert_not @day.valid?
  end

  test "date should be present" do
    @day.date = nil
    assert_not @day.valid?
  end

  test "date should be unique in scope of diary" do
    day, day_2 = @days.first, @days.second
    assert day.valid?

    day_from_another_diary = create :day
    day.date = day_from_another_diary.date
    assert day.valid?

    day.date = day_2.date
    assert_not day.valid?
  end

  test "should be ordered by date DESC" do
    @days = Day.all
    previous_date = nil
    @days.each do |day|
      assert day.date < previous_date if previous_date.present?
      previous_date = day.date
    end
  end

  test "reverse_ordered scope should reorder by date ASC" do
    @days = Day.reverse_ordered
    previous_date = nil
    @days.each do |day|
      assert day.date > previous_date if previous_date.present?
      previous_date = day.date
    end
  end

end