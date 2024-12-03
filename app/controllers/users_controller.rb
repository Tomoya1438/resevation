class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts 
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
    redirect_to '/'   
  end


  private

  def user_params
    params.require(:user).permit(:name)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
  
end
