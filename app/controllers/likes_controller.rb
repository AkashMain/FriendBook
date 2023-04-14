class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @posts = Post.all.order(created_at: :desc)
    @likable = find_likable
    @like = find_likable.likes.build(user: current_user)

    if @like.save
      if @like.likable.is_a? Post
        respond_to do |format| 
          format.html {redirect_to posts_path, notice: 'You liked this POST'}
          format.js {render 'create.js.erb'}
        end
      else 
        @post = Post.find(params[:post_id])
        respond_to do |format| 
          format.html {redirect_to post_path(@post), notice: 'You liked this COMMENT'}
          format.js {render 'create_comment_like.js.erb'}
        end 
      end
    else 
      respond_to do |format| 
        format.html {redirect_to posts_path, notice: 'Sorry, something went wrong'}
        format.js
      end 
    end
  end

  def destroy
    @posts = Post.all.order(created_at: :desc)
    @likable = find_likable
    @like = find_likable.likes.find(params[:id])

    if @like.user == current_user && @like.destroy
      if @like.likable_type=="Post"
        respond_to do |format| 
          format.html {redirect_to posts_path, notice: 'You disliked this post'}
          format.js {render 'destroy.js.erb'}
        end
      else 
        @post = Post.find(params[:post_id])
        respond_to do |format| 
          format.html {redirect_to post_path(@post), notice: 'You disliked this COMMENT'}
          format.js {render 'destroy_comment_like.js.erb'}
        end 
      end
    else
      respond_to do |format| 
        format.html {redirect_to posts_path, alert: "Sorry, something went wrong. Please try again."}
        format.js 
      end
    end
  end

  private 

  def find_likable 
    if(params[:comment_id]).present?
      Comment.find(params[:comment_id])
    else 
      Post.find(params[:post_id])
    end  
  end
end
