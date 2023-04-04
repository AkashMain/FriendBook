class FriendshipsController < ApplicationController
    
    def index 
        @users_except_me = User.where.not(id: current_user.id)
        @pending_requests = current_user.received_friend_requests.pending_requests
        @accepted_requests = current_user.sent_friend_requests.accepted_requests
        @declined_requests = current_user.sent_friend_requests.declined_requests
        # @suggested_users = User.find(params[:receiver_id])
    end
    
    def show  
        @accepted_requests = current_user.sent_friend_requests.accepted_requests
        @suggested_user = User.find(params[:id])
    end

    def create_request
        #@friendship = current_user.frendships.build(friendship_params)
        # @friendship = Friendship.new(friendship_params)
        @suggested_user = User.find(params[:id])
        @friendship = current_user.sent_friend_requests.build(receiver_id: @suggested_user.id ,status: :pending)

        if @friendship.save  
            flash[:success] = "Friend request sent to #{@suggested_user.fname}"
            redirect_to users_path
        else
            flash[:error] = "Error while sending friend request"
            redirect_to users_path
        end

    end

    def accept_request
        @friendship = Friendship.find(params[:id])                     #retrieve existing record
        if @friendship.accepted! 
            flash[:success] = 'Friend request accepted'
            redirect_to current_user
        else
            flash[:error] = 'Error while accepting friend request'
            redirect_to current_user
        end

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
    
    def destroy 
        @friendship = Friendship.find(parmas[:id])
        @friendship.destroy
        flash[:notcie] = 'Friend removed'
        redirect_to users_path
    end
    private
    
    def friendship_params
        params.require(:friendship).permit(:sender_id,:receiver_id,:status)
    end
    
    # def current_user
    #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # end

end
