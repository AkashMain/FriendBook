Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root 'posts#index'
  devise_for :users

  # resources :users do 
  #   resources :friendships
  resources :friendships do 
    collection do
      get :pending_req
    end

    member do 
      post :create_request
      post :accept_request
      post :decline_request
    end
  end

  resources :posts do
    resources :comments, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
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