class ApplicationController < ActionController::Base

  before_action :set_up_diary_and_dates, if: :user_signed_in?
  before_action :configure_permitted_params, if: :devise_controller?
  before_action :authenticate_user!

  helper_method :current_user, :user_signed_in?

  protected

  def set_up_diary_and_dates
    @diary = current_user.diary || current_user.create_diary
    @diary_created = @diary.created_at.to_date
    @diary_entries = @diary.diary_entries.persisted
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
