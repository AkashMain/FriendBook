class LikesController < ApplicationController
  
  def create
    @post = Post.find(pramas[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save 
      redirect_to @post, notice: 'You liked this post'
    else 
      redirect_to @post, : 'Sorry, something went wrong'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])

    if @like.user == current_user && @like.destroy
      redirect_to @post, notice: "You unliked this post."
    else
      redirect_to @post, alert: "Sorry, something went wrong. Please try again."
    end
  end

end
