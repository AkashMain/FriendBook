class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # attr_accessor :full_name       

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages
  has_many :conversations, through: :messages
  has_one_attached :profile_picture


  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy   
  has_many :sent_friends, through: :sent_friend_requests, source: :receiver     #user's friends req
  
  has_many :received_friend_requests, class_name: 'Friendship', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy  
  has_many :received_friends, through: :received_friend_requests, source: :sender    #user's received friends req


  has_many :accepted_sent_friend_requests, -> { where(status: 'accepted') }, class_name: 'Friendship', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy
  has_many :accepted_sent_friends, through: :accepted_sent_friend_requests, source: :receiver     #user's friends req
  
  has_many :accepted_received_friend_requests, -> { where(status: 'accepted') }, class_name: 'Friendship', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy
  has_many :accepted_received_friends, through: :accepted_received_friend_requests, source: :sender    #user's received friends req

  validates :fname, presence: true
  # validates :lname, presence: true
  # validates :email, presence: true

  #getter method
  def full_name  
    "#{self.fname} #{self.lname}"
  end

  #setter method
  def full_name=(val)
    parts = val.split()
    self.fname = parts.first
    self.lname = parts.second
  end 
  
  def friends 
    accepted_sent_friends + accepted_received_friends            #both working
    # return sent_friend_requests.where(status: 'accepted').map(&:receiver) + received_friend_requests.where(status: 'accepted').map(&:sender)
  end
  
end
