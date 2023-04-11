class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true, length: {maximum: 300}

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def editable_by?(user)
    user == self.user
  end
end
