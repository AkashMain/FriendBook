class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save 
      redirect_to posts_path, notice: 'You liked this post'
    else 
      redirect_to posts_path, notice: 'Sorry, something went wrong'
    end
  end

  def destroy
    # binding.pry
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])

    if @like.user == current_user && @like.destroy
      redirect_to posts_path, notice: "You unliked this post."
    else
      redirect_to posts_path, alert: "Sorry, something went wrong. Please try again."
    end
  end

end
