class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :content, presence: true 
  validate :cant_comment_own_post

  def cant_comment_own_post
    return unless post

    if user_id == post.user_id
      errors.add(:user_id, "User can not comment on his own post") 
    end
  end
  
  # optional: add a default scope to sort comments by creation date
  default_scope -> { order(created_at: :asc) }
end
