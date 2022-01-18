module DayHelper

  def day_by_date(date)
    Day.where(diary_id: @diary.id, date: date).first
  end

  def day_link(day)
    "/#{day.date.to_date}"
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

  def current_day?(day) 
    day.date == DateTime.current.to_date
  end

  def format_excerpt(excerpt, title)
    excerpt.gsub!("<br>", " <br>")
    excerpt.gsub!("</h1>", " </h1>")
    excerpt.gsub!("</div>", " </div")
    excerpt.gsub!("  ", " ")
    excerpt = "<span>#{title}</span> #{excerpt}"
    sanitize excerpt, tags: %w(span)
  end

end