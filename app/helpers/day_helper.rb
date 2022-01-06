module DayHelper

  def day_by_date(date)
    Day.where(diary_id: @diary.id, date: date).first
  end

  def next_day
    date = (@day.date + 1.day).to_date
    day_path(date)
  end

  def prev_day
    date = (@day.date - 1.day).to_date
    day_path(date)
  end

  def next_day?
    @day.date < DateTime.current.to_date
  end

  def prev_day?
    @day.date > @diary_created
  end

end