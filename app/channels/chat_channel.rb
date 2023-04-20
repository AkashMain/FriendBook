class ChatChannel < ApplicationCable::Channel
  def subscribed
    # When a user subscribes to the ChatChannel, they will be added to a stream that's specific to the conversation they're a part of.
    # conversation = Conversation.find(params[:conversation])
    # stream_for conversation

     #subscribes the user to a unique channel based on their id,users have own private channel 
    # stream_from "chat_#{params[:conversation_id]}"  
    stream_from "chat_channel"
    
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def receive(data)
  #   # Create a new message and broadcast it to the conversation
  #   message = current_user.messages.create(body: data['message'], conversation_id: data['conversation_id'])
  #   ChatChannel.broadcast_to(message.conversation, message)
  # end

  # def send_message(data)
  #   message = Message.create(body: data['message'], user_id: current_user.id, conversation_id: params[:conversation_id])
  #   if message.persisted?
  #     ActionCable.server.broadcast("chat_#{params[:conversation_id]}", message: message.body, user: message.user.email)
  #   end
  # end

end
