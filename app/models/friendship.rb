class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: sender_id
  belongs_to :receiver, class_name: 'User', foreign_key: receiver_id

  validates :sender_id, uniqueness: { scope: :receiver_id }
  
  enum status: {
    pending : 0,
    accepted : 1,
    declined : 2
  }
  
  scope :pending_requests, ->{where(status: :pending)}
  scope :accepted_requests, ->{where(status: :accepted)}
  scope :declined_requests, ->{where(status: :declined)}

  # def accept 
  #   self.update(status: :accepted)
  # end

  # def decline   
  #   self.update(status: :declined)
  # end

end
