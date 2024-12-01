class PostsController < ApplicationController
  def new
    @post = Post.new 
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all 
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to @post
    else
       @posts = Post.all
       render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])  
    post.destroy  
    redirect_to '/posts'   
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end