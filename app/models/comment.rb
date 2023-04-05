class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, presence: true 

  # optional: add a default scope to sort comments by creation date
  default_scope -> { order(created_at: :asc) }
end
