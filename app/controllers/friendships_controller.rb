class FriendshipsController < ApplicationController
    
    def pending_req
        @pending_requests = current_user.pending_requests  
    end
    
    def create_request
        #@friendship = current_user.frendships.build(friendship_params)
        # @friendship = Friendship.new(friendship_params)
        # @friend = User.find(params[:friend_id])
        @friend = User.find(params[:receiver_id])
        @friendship = Friendship.new(sender_id: current_user, receiver_id: @friend,status: :pending)

        if @friendship.save  
            flash[:success] = 'Friend request sent to #{friend.fname}'
        else
            flash[:error] = 'Error while sending friend request'
        end

        redirect_to users_path
    end

    def accept_request
        @friendship = Friendship.find(params[:id])
        if @friendship.accepted! 
            flash[:success] = 'Friend request accepted'
        else
            flash[:error] = 'Error while accepting friend request'
        end

        redirect_to current_user
    end

    def decline_request
        @friendship = Friendship.find(params[:id])
        if @friendship.declined!
            flash[:success] = 'Friend request declined'
        else
            flash[:error] = 'Error while declining friend request'
        end

        redirect_to users_path
    end

    private
    
    def friendship_params
        params.require(:friendship).permit(:sender_id,:receiver_id,:status)
    end
    
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end
