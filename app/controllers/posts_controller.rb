

class PostsController < ApplicationController
  before_action :authenticate_user!
  
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
    CreateDelayedPostJob.set(wait: 10.seconds).perform_later(current_user.id,post_params)
    redirect_to posts_path
    
    # if @post.save
    #   # CreateDelayedPostJob.set(wait_until: 1.minutes.from_now).perform_later(@post.id)
    #   flash[:notice] = "Post was successfully created"

    # else
    #   render :new
    # end
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
    params.require(:post).permit(:body, :image)
  end

  #for edit, update, destroy
  def authorize_user
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user == @post.user
  end
    
end
