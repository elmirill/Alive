class ApplicationController < ActionController::Base

  before_action :current_user, :require_user
  before_action :set_dates_and_diary, if: :current_user?

  helper_method :current_user, :current_user?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    redirect_to signin_path
  end

  def current_user?
    !!@current_user
  end

  def require_user
    unless current_user?
      flash[:notice] = "Please sign in first"
      redirect_to signup_path
    end
  end

  def redirect_if_logged_in
    redirect_to root_path if current_user?
  end

  protected

  def set_dates_and_diary
    @diary = @current_user.diary || @current_user.create_diary
    @diary_created = @diary.created_at.to_date
    @diary_entries = @diary.diary_entries
    @today_date = DateTime.current.to_date
  end

end
