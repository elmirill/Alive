class DaysController < ApplicationController

  before_action :set_diary, :set_today_date
  before_action :set_day, only: :show

  def index
    today = @today_date
    @days = []
    while today >= @diary_created do
      @days << today
      today -= 1.day
    end
  end

  def show
    redirect_to days_path if @day.nil?
  end

  def create
    @day = @diary.days.new(day_params)
    redirect_to day_path(date: day_params[:date]) if @day.save
  end

  private

  def set_diary
    # TODO: bind to user
    @diary = Diary.first || Diary.create!
    @diary_created = @diary.created_at.to_date
  end

  def set_today_date
    @today_date = DateTime.current.to_date
  end

  def set_day
    date = params[:date].present? ? params[:date] : @today_date
    @day = Day.where(diary_id: @diary.id, date: date).first
  end

  def day_params
    params.require(:day).permit(:date)
  end

end