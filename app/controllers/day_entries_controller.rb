class DayEntriesController < ApplicationController

  before_action :set_day_entry

  def update
    unless @day_entry.update(day_entry_params)
      flash[:alert] = "Error: entry wasn't updated."
    end
  end

  private

  def set_day_entry
    @day_entry = DayEntry.find(params[:id])
  end

  def day_entry_params
    params.require(:day_entry).permit(:text, :line, :check, :rich_text)
  end

end