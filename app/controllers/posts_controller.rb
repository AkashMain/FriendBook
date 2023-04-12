class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all.order(created_at: :desc)
    # @like = current_user.posts.find(params[:id]).likes.find(params[:like_id])
    # @like = Like.find_by(user_id: current_user.id, post_id: params[:id])              
    # @like = Post.find(params[:id]).likes.find(params[:id])

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

  def like 
    @like = current_user.likes.new(post_id :@post.id)
    if @like.save 
      redirect_back fallback_location: root_path, notice: 'Post was successfully liked.'
    else
      redirect_back fallback_location: root_path, alert: 'Error liking post.'
    end 
  end
  
  def unlike
    @like = current_user.likes.find_by(post_id: @post.id)
    if @like.destroy
      redirect_back fallback_location: root_path, notice: 'Post was successfully unliked.'
    else
      redirect_back fallback_location: root_path, alert: 'Error unliking post.'
    end
  end

  private 

  def post_params
    params.require(:post).permit(:body)
  end

  #for edit, update, destroy
  def authorize_user
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user == @post.user
  end
    
end
