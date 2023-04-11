class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true, counter_cache: true                      #auto update counts
  belongs_to :commment, optional: true

  validates :user_id, uniqueness: {scope: :post_id}

  def self.increment_counter(post_id)
    where(post_id: post_id).count
  end
  
end
