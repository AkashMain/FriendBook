class ConversationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @conversations = current_user.conversations.includes(:messages).distinct
      @friends = current_user.friends
    end
  
    def create
      sender_id = current_user.id
      receiver_id = params[:receiver_id]
  
      # Check if a conversation already exists with the same sender and receiver
      conversation = Conversation.between(sender_id, receiver_id).first
  
      unless conversation
        # If a conversation doesn't exist, create a new one
        conversation = Conversation.create(sender_id: sender_id, receiver_id: receiver_id)
      end
  
      redirect_to conversation_messages_path(conversation)
    end
end
  
  