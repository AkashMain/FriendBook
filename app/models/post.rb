class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_one_attached :image

  validates :body, presence: true, length: {maximum: 300}

  # def self.search(q)
  #   if q
  #     where('body LIKE ?', "%#{q}%") 
  #   else
  #     all
  #   end
  # end
  scope :searching, ->(query) {where("body LIKE ?", "%#{query}%")}

end
