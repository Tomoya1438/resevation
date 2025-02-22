class Admin::SearchesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
