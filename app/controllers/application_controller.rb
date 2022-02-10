class ApplicationController < ActionController::Base

  # before_action :current_user, :require_user
  before_action :set_dates_and_diary, if: :user_signed_in?
  before_action :configure_permitted_params, if: :devise_controller?

  helper_method :current_user, :user_signed_in?

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # rescue ActiveRecord::RecordNotFound
  #   session[:user_id] = nil
  #   redirect_to signin_path
  # end

  # def user_signed_in?
  #   !!@current_user
  # end

  # def require_user
  #   unless user_signed_in?
  #     flash[:notice] = "Please sign in first"
  #     redirect_to signin_path
  #   end
  # end

  # def redirect_if_logged_in
  #   redirect_to days_path if user_signed_in?
  # end

  protected

  def set_dates_and_diary
    @diary = current_user.diary || current_user.create_diary
    @diary_created = @diary.created_at.to_date
    @diary_entries = @diary.diary_entries
    @today_date = DateTime.current.to_date
  end

  # Devise tweaks
  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def after_sign_out_path_for(resource_name)
    signin_path
  end

end
