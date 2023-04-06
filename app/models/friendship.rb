class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  validates :sender_id, uniqueness: { scope: :receiver_id }
  validate :receiver_cannot_send_request_to_friend

  def receiver_cannot_send_request_to_friend
    if Friendship.exists?(sender_id: sender_id, receiver_id: receiver_id, status: 'accepted') || 
      Friendship.exists?(sender_id: receiver_id, receiver_id: sender_id)
      errors.add(:receiver_id, "Receiver cannot send a friend request to someone who is already their friend.")
    end
  end

  enum status: [:pending, :accepted, :declined]
  
  scope :pending_requests, ->{where(status: :pending)}
  scope :accepted_requests, ->{where(status: :accepted)}
  scope :declined_requests, ->{where(status: :declined)}
  
  def self.friends_of(user)
    where(sender: user, status: :accepted).or(where(receiver: user, status: :accepted))
  end
end

# validate :unique_sender_receiver_ids
# validate :sender_send_one_request

# def unique_sender_receiver_ids
#   if Friendship.exists?(sender_id: receiver_id, receiver_id: sender_id)
#     errors.add(:sender_id, "Sender and Receiver IDs must be unique in both directions")
  #     errors.add(:receiver_id, "Sender and Receiver IDs must be unique in both directions")
  #   end
  # end
  
  # def sender_send_one_request
  #   if Friendship.exists?(sender_id: sender_id, receiver_id: receiver_id)
  #     errors.add(:sender_id, "Sender cant send friend request multiple times to same receiver")
  #   end
  # end
  
  # enum status: {
    #   pending :0,
    #   accepted :1,
    #   declined :2
    # }
    
    
    # def accept 
    #   self.update(status: :accepted)
    # end
    
    # def decline   
    #   self.update(status: :declined)
    # end