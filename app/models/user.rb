class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  # has_many :friendships

  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy   
  has_many :received_friend_requests, class_name: 'Friendship', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy  
  
  has_many :sent_friends, through: :sent_friend_requests, source: :receiver     #user's friends req
  has_many :received_friends, through: :received_friend_requests, source: :sender    #user's inverse friends req


  scope :pending_requests, ->{received_friend_requests.where(status: :pending)}
  scope :accepted_requests, ->{received_friend_requests.where(status: :accepted)}
  scope :declined_requests, ->{received_friend_requests.where(status: :declined)}

  # scope :pending_requests, ->{ joins(:received_friend_requests).where(friendships: {status: :pending})}
  # scope :accepted_requests, ->{ joins(:received_friend_requests).where(friendships: {status: :accepted})}
  # scope :declined_requests, ->{ joins(:received_friend_requests).where(friendships: {status: :declined})}

  # has_many :accepted_requests, ->{where(status: :accepted)}, class_name: 'Friendship', foreign_key: ''
  # has_many :declined_requests, ->{where(status: :declined)}, class_name: 'Friendship', foreign_key: ''

end
