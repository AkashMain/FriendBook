class CommentsController < ApplicationController
  before_action :set_post


  def new
    @comment = @post.comments.build()
  end

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save 
      redirect_to @post, notice: "Comment was successfully created."
    else  
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy 
    @comment = Comment.find(params[:id])
    @comment.destroy 
    redirect_to @post, notice: "Comment was successfuly deleted"
  end
    
  private 

  def set_post 
    @post = Post.find(params[:post_id])
  end
  
  def comment_params 
    params.require(:comment).permit(:content)
  end
end
