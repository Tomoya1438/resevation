class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @posts = Post.all 
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new 
  end

  def create
    @post = current_admin.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to admin_post_path(@post)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集完了"
      redirect_to admin_post_path(@post)
    else
      @posts = Post.all
      flash.now[:alert] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])  
    post.destroy  
    redirect_to admin_posts_path  
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
