Rails.application.routes.draw do
  devise_for :users

  get 'users/index'
  get 'users/show'
  root 'posts#index'
  get 'users/:user_id/friendships', to: 'friendships#index'
  # post '/users/:user_id/friendships/:receiver_id/create_request', to: 'friendships#create_request', as: 'create_request'

  # resources :users do 
  #   resources :friendships
  resources :users do 
    resources :friendships , only: [:index, :show] do 
      member do 
        post :create_request
        put :accept_request
        put :decline_request
      end
    end
  end
   
  resources :posts do
    resources :comments, only: [:create, :destroy] 
    resources :likes, only: [:create, :destroy] 
  end


  # resources :users do
  #   member do
  #     get :friends
  #     get :pending_friend_requests
  #     get :friend_requests_received
  #     post :accept_friendship
  #     post :decline_friendship
  #   end 
  # end
  
  # put 'users/:id/accept_friendship', to: 'users#accept_friendship', as: 'accept_friendship'
  # put 'users/:id/decline_friendship', to: 'users#decline_friendship', as: 'decline_friendship'
  # get 'users/pending_friend_requests', to: 'users#pending_friend_requests', as: 'pending_friend_requests'
  # get 'users/friend_requests_received', to: 'users#friend_requests_received', as: 'friend_requests_received'
  # get 'users/friends', to: 'users#friends', as: 'friends'

end