class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy   
  has_many :sent_friends, through: :sent_friend_requests, source: :receiver     #user's friends req
  
  has_many :received_friend_requests, class_name: 'Friendship', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy  
  has_many :received_friends, through: :received_friend_requests, source: :sender    #user's received friends req


  has_many :accepted_sent_friend_requests, -> { where(status: 'accepted') }, class_name: 'Friendship', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy
  has_many :accepted_sent_friends, through: :accepted_sent_friend_requests, source: :receiver     #user's friends req
  
  has_many :accepted_received_friend_requests, -> { where(status: 'accepted') }, class_name: 'Friendship', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy
  has_many :accepted_received_friends, through: :accepted_received_friend_requests, source: :sender    #user's received friends req

  def friends 
    accepted_sent_friends + accepted_received_friends            #both working
    # return sent_friend_requests.where(status: 'accepted').map(&:receiver) + received_friend_requests.where(status: 'accepted').map(&:sender)
  end
  
  # scope :pending_requests, ->{received_friend_requests.where(status: :pending)}  ->undefined local variable or method `received_friend_requests' 
  # scope :accepted_requests, ->{received_friend_requests.where(status: :accepted)}
  # scope :declined_requests, ->{received_friend_requests.where(status: :declined)}

  scope :pending_requests, ->{ joins(:received_friend_requests).where(friendships: {status: :pending})}
  scope :accepted_requests, ->{ joins(:received_friend_requests).where(friendships: {status: :accepted})}
  scope :declined_requests, ->{ joins(:received_friend_requests).where(friendships: {status: :declined})}

  # has_many :accepted_requests, ->{where(status: :accepted)}, class_name: 'Friendship', foreign_key: ''
  # has_many :declined_requests, ->{where(status: :declined)}, class_name: 'Friendship', foreign_key: ''


end
#users' friend
# friends = current_user.sent_friend_requests.where(status: 'accepted').map(&:receiver) + current_user.received_friend_requests.where(status: 'accepted').map(&:sender)
# user = User.find(1)
# friends = user.sent_friends+user.received_friends
# OR
# has_many :friendships
# has_many :friends, through: :friendships                 friends->user's friends