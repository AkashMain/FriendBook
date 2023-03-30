class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:notice] = "Post was successfully created"
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post was successfult deleted"
    redirect_to root_path
  end

  private 

  def post_params
    params.require(:post).permit(:body)
  end
    
end
