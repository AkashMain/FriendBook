class RenameCommentInLikes < ActiveRecord::Migration[5.2]
  def up 
    rename_column :likes, :commment_id, :comment_id
  end

  def down 
    rename_column :likes, :comment_id, :commment_id
  end
end
