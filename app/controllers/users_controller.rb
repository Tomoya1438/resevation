class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @comments = @user.comments
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    user = User.find(params[:id])  
    user.destroy  
    redirect_to new_user_registration_path   
  end

  def guest_login
    @user = User.guest_login
    sign_in(@user)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    @user = User.find_by_id(params[:id])
    unless @user == current_user
      redirect_to posts_path
    end
  end
  
end
