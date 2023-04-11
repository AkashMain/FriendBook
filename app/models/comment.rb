class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, presence: true 
  validate :cant_comment_own_post

  def cant_comment_own_post
    if user_id == post.user_id
      errors.add(:user_id, "User can not comment on his own post") 
    end
  end

  def deletable_by?(user)
    user == self.user
  end
  
  # optional: add a default scope to sort comments by creation date
  default_scope -> { order(created_at: :asc) }
end
