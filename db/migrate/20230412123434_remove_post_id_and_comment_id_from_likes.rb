class RemovePostIdAndCommentIdFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :likes, :posts, foreign_key: true
    remove_reference :likes, :comments, foreign_key: true
  end
end
