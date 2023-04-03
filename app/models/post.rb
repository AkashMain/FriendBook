class Post < ApplicationRecord

  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy

  validates :body, presence: true, length: {maximum: 300}

  def likedby(user)
    likes.where(user_id: user.id).exists?
  end
end
