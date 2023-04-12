class LikesController < ApplicationController
  
  def create
    @posts = Post.all.order(created_at: :desc)
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save 
      respond_to do |format| 
        format.html {redirect_to posts_path, notice: 'You liked this post'}
        format.js
      end
    else 
      respond_to do |format| 
        format.html {redirect_to posts_path, notice: 'Sorry, something went wrong'}
        format.js
      end 
    end
  end

  def destroy
    # binding.pry
    @posts = Post.all.order(created_at: :desc)
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])

    if @like.user == current_user && @like.destroy
      respond_to do |format| 
        format.html {redirect_to posts_path, notice: "You unliked this post."}
        format.js
      end
    else
      respond_to do |format| 
        format.html {redirect_to posts_path, alert: "Sorry, something went wrong. Please try again."}
        format.js 
      end
    end
  end

end
