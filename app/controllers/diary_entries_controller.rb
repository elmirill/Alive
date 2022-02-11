class DiaryEntriesController < ApplicationController

  before_action :set_diary_entry, only: [:edit, :update, :destroy]

  def index
    @diary_entry = DiaryEntry.new
  end

  def create
    @diary_entry = @diary.diary_entries.new(diary_entry_params)
    if @diary_entry.save
      flash[:notice] = "Diary entry created."
      redirect_to edit_diary_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @diary_entry.update(diary_entry_params)
      flash[:notice] = "Diary entry updated."
      redirect_to edit_diary_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary_entry.destroy
    flash[:notice] = "Diary entry deleted."
    redirect_to edit_diary_path
  end

  private

  def set_diary_entry
    @diary_entry = @diary.diary_entries.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to edit_diary_path
  end

  def diary_entry_params
    params.require(:diary_entry).permit(:title, :entry_type, :sort_order, :hidden)
  end

end