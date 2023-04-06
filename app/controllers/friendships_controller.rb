class FriendshipsController < ApplicationController
    
    def index 
        @users_except_me = User.where.not(id: current_user.id)
        @pending_requests = current_user.received_friend_requests.pending_requests
        @accepted_requests = current_user.sent_friend_requests.accepted_requests
        @declined_requests = current_user.sent_friend_requests.declined_requests
        # @suggested_users = User.find(params[:receiver_id])
        @friends_show = Friendship.friends_of(current_user) 
    end
    
    def show  
        @accepted_requests = current_user.sent_friend_requests.accepted_requests
        @suggested_user = User.find(params[:id])
    end

    def create_request
        @suggested_user = User.find(params[:id])
        @friendship = current_user.sent_friend_requests.build(receiver_id: @suggested_user.id ,status: :pending)    
        if @friendship.save  
            # flash[:success] = "Friend request sent to #{@suggested_user.fname}"
            respond_to do |format|
                format.html {redirect_to user_friendships_path, notice: "Friend request sent to #{@suggested_user.fname}"}
                format.js
            end
        else
            # flash[:error] = "Error while sending friend request"
            respond_to do |format|
                format.html {redirect_to user_friendships_path, notice: "Error while sending friend request"}
                format.js
            end
        end
    end

    def accept_request
        @friendship = Friendship.find(params[:id])                     #retrieve existing record
        if @friendship.accepted! 
            respond_to do |format|
                format.html {redirect_to user_friendships_path, notice: "Friend request accepted"}
                format.js      
            end      
        else
            respond_to do |format|
                format.html {redirect_to user_friendships_path, notice: "Error while accepting friend request"}         #current_user 
                format.js 
            end
        end
    end

    def decline_request
        @friendship = Friendship.find(params[:id])
        if @friendship.declined!    
            flash[:success] = 'Friend request declined'
        else
            flash[:error] = 'Error while declining friend request'
        end
        respond_to do |format|
            format.html {redirect_to user_friendships_path}
            format.js 
        end
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
