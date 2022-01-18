class ApplicationController < ActionController::Base

  before_action :set_dates_and_diary

  protected

  def set_dates_and_diary
    # TODO: bind to user
    @diary = Diary.first || Diary.create!
    @diary_created = @diary.created_at.to_date
    @diary_entries = @diary.diary_entries
    @today_date = DateTime.current.to_date
  end

end
