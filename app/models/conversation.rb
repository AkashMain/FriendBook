class Conversation < ApplicationRecord
    belongs_to :sender, class_name: "User", foreign_key: 'sender_id'
    belongs_to :receiver, class_name: "User", foreign_key: 'receiver_id'
    has_many :messages, dependent: :destroy  
    
    validates :sender_id, uniqueness: { scope: :receiver_id }
    
    scope :between, -> (sender_id, receiver_id) do
      where(sender_id: sender_id, receiver_id: receiver_id)
        .or(where(sender_id: receiver_id, receiver_id: sender_id))
    
    end
end

