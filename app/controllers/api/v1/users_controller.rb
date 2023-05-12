module Api 
    module V1
        class UsersController < ApplicationController
            skip_before_action :authenticate_user!
            skip_before_action :verify_authenticity_token
 
            def index 
                @users = User.all
                render json: @users, each_serializer: UserSerializer
            end
            
            def show 
                @user = User.find(params[:id])
                @posts = @user.posts.order(created_at: :desc)
                @friends = @user.friends    
                render json: {user: @user, posts: @posts, friends: @friends}
            end
            
            def create
                @user = User.new(user_params)
                if @user.save
                  render json: @user, status: :created
                else
                  render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            def update
                @user = User.find(params[:id])
                if @user.update(user_params)
                  render json: @user
                else
                  render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            def destroy 
              @user = User.find(params[:id])
              @user.destroy
              render json: {message: "User successfully deleted"}
            end
            
            private

            def user_params
              params.require(:user).permit(:email, :password, :password_confirmation, :fname, :lname, :full_name)
            end
        end
    end
end
