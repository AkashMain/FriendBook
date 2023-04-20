class AddSenderAndReceiverToConversations < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :sender, foreign_key: {to_table: :users}
    add_reference :conversations, :receiver, foreign_key: {to_table: :users}
  end
end
