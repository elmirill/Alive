class PagesController < ApplicationController

  skip_before_action :require_user, only: [:about]

  def about
  end

  def settings
    @user = @current_user
  end

end