class UsersController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @users = User.all.order(:fname)
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.order(created_at: :desc)
    @pending_friendship_requests_received = @user.pending_requests
    @accepted_friendship_requests_received = @user.accepted_requests
    @declined_friendship_requests_received = @user.declined_requests        
  end

  private 
  
  def user_params 
    params.require(:user).permit(:fname,:lname,:email,:password,:password_confirmation)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  
end

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