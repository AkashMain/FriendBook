

class PostsController < ApplicationController
  before_action :authenticate_user!
  # protect_from_forgery except: :index

  def index
    @posts = Post.all.searching(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    # @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:notice] = "Post was successfully created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy 
    @post = current_user.posts.find(params[:id])
    # unless @post.editable_by?(current_user)
    #   redirect_to @post, alert: "You are not authorized to delete this post."
    # end
    @post.destroy
    flash[:notice] = "Post was successfult deleted"
    redirect_to root_path
  end

  private 

  def post_params
    params.require(:post).permit(:body, :image)
  end

  #for edit, update, destroy
  def authorize_user
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user == @post.user
  end
    
end
