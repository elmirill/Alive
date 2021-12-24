class DayEntriesController < ApplicationController

  before_action :set_day_entry

  def update
    if @day_entry.update(day_entry_params)
      redirect_to day_path(date: @day_entry.day.date.to_date)
    else
      #TODO Process exception
      flash[:alert] = "Error: entry wasn't updated."
      redirect_to day_path(date: @day_entry.day.date.to_date)
    end
  end

  private

  def set_day_entry
    @day_entry = DayEntry.find(params[:id])
  end

  def day_entry_params
    params.require(:day_entry).permit(:text, :line, :check)
  end

end