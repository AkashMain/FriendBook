class UsersController < ApplicationController

  def index
    @users = User.all.order(:fname)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @friends = @user.friends
    # @pending_friendship_requests_received = User.pending_requests.find(params[:id])
    # @accepted_friendship_requests_received = @user.accepted_requests
    # @declined_friendship_requests_received = @user.declined_requests        
  end

  private 
  
  def user_params 
    params.require(:user).permit(:email, :password, :password_confirmation, :profile_picture)
  end
  
  #@user.profile_picture.purge    delete profile_picture 
       
end



# def current_user
#   @current_user ||= User.find(session[:user_id]) if session[:user_id]
# end

# def sent_friend_request
#   @friendship = Friendship.new(sender_id: current_user.id, receiver_id: params[:receiver_id])

#   if @friendship.save 
#     flash[:success] = 'Friend request sent'
#   else
#     flash[:error] = 'Error sending friend request'
#   end
#   redirect_to users_path
# end

# def accept_friend_request 
#   @friendship = Friendship.find(params[:id])
  
#   if @friendship.accept       
#     flash[:success] = 'Friend request accepted'
#   else
#     flash[:error] = 'Error accepting friend request'
#   end
#   redirect_to current_user
# end