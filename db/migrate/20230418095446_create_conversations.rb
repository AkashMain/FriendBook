class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, foreign_key: { to_table: :users }
      t.integer :receiver_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
