class UsersController < ApplicationController

  # before_action :set_user, onny: [:update, :destroy]
  # before_action :redirect_if_logged_in, only: [:new, :create]
  
  # skip_before_action :require_user, only: [:new, :create]

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     flash[:notice] = "Welcome aboard!"
  #     redirect_to edit_diary_path
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def update
  #   if @user.update(user_params)
  #     flash[:notice] = "Updated!"
  #     redirect_to settings_path
  #   else
  #     render "pages/settings", status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @user.destroy
  #   session[:user_id] = nil
  #   flash = "Your data has been deleted"
  #   redirect_to signup_path
  # end

  # private

  # def set_user
  #   @user = @current_user
  # end

  # def user_params
  #   params.require(:user).permit(:email, :first_name, :last_name, :password)
  # end

end