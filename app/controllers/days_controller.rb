class DaysController < ApplicationController

  before_action :set_today_date
  before_action :set_day, only: :show

  def index
    today = @today_date
    @dates = []
    while today >= @diary_created do
      @dates << today
      today -= 1.day
    end
  end

  def show
    redirect_to days_path if @day.nil?
    @day_entries = @day.day_entries.ordered
  end

  def create
    @day = @diary.days.new(day_params)
    redirect_to day_path(date: day_params[:date]) if @day.save
  end

  private

  def set_today_date
    @today_date = DateTime.current.to_date
  end

  def set_day
    date = params[:date].present? ? params[:date] : @today_date
    @day = Day.where(diary_id: @diary.id, date: date).first
    @day = @diary.days.create(date: date) if @day.blank?
  end

  def day_params
    params.require(:day).permit(:date)
  end

end