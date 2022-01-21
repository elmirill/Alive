class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create]

  skip_before_action :require_user, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in"
      redirect_to root_path
    else
      flash[:notice] = "Email or password is not correct"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to signin_path
  end

end