class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:about, :check_email]

  def about
  end

  def settings
    @user = current_user
  end

  def check_email
    redirect_to auth_root_path if user_signed_in?
  end

end