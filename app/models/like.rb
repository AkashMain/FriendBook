class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true


  validates :user_id, uniqueness: {scope: [:likable_type, :likable_id]}                          #user can only likes once

  def self.increment_counter(likable_id)
    where(likable_id: likable_id).count
  end
  
end
