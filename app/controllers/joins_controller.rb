class JoinsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @join = current_user.joins.new(post_id: post.id)
    @join.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    @join = current_user.joins.find_by(post_id: post.id)
    @join.destroy
    redirect_to post_path(post)
  end

end
