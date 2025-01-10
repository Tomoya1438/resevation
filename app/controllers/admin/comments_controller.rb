class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment&.destroy
    flash[:noticce] = "削除しました"
    redirect_to admin_comments_path
  end

end
