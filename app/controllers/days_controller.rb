class DaysController < ApplicationController

  before_action :set_days
  before_action :set_day, only: :show

  def index
  end

  def show
    redirect_to days_path if @day.nil?
    @day_entries = @day.day_entries
  end

  private

  def set_day
    date = params[:date].present? ? params[:date] : @today_date
    @day = @diary.days.where(date: date).take
  end

  def set_days
    date = @diary_created - 7.days
    while date <= @today_date do
      day = @diary.days.where(date: date).take
      day = @diary.days.create(date: date) if day.blank?
      date += 1.day
    end
    @days = @diary.days
  end

  def day_params
    params.require(:day).permit(:date)
  end

end