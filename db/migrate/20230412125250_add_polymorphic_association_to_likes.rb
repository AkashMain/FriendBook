class AddPolymorphicAssociationToLikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :post_id, :integer
    remove_column :likes, :comment_id, :integer 
    add_reference :likes, :likable, polymorphic: true

    # add_index :likes, [:likable_type, :likable_id]                      #better performance

  end
end
