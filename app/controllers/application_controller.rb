class ApplicationController < ActionController::Base

  before_action :set_diary_and_entries

  protected

  def set_diary_and_entries
    # TODO: bind to user
    @diary = Diary.first || Diary.create!
    @diary_created = @diary.created_at.to_date
    @diary_entries = @diary.diary_entries.ordered
  end

end
