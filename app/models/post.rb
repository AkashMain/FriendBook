class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_one_attached :image

  validates :body, presence: true, length: {maximum: 300}

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def editable_by?(user)
    user == self.user
  end
end
