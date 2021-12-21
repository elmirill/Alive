module DayHelper

  def day_by_date(date)
    Day.where(diary_id: @diary.id, date: date).first
  end

end