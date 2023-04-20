class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
      @conversation = Conversation.find(params[:conversation_id])
      @messages = @conversation.messages.order(created_at: :desc).limit(50).reverse
      @message = @conversation.messages.build
    end

    def create
      @conversation = Conversation.find(params[:conversation_id])
      @message = @conversation.messages.build(message_params)
      @message.user = current_user
      
      if @message.save
        ActionCable.server.broadcast 'chat_channel', message: render_message(@message)
        # ChatChannel.broadcast_to(@conversation, message: render_message(@message))
        respond_to do |format|
          format.js { render 'index' }
        end

        # head :ok                          #successful HTTP status code
      else
        redirect_to conversation_path(@conversation)
      end
    end
  
    private
  
    # Helper method to render the message partial for ActionCable broadcast
    def render_message(message)
      render_to_string(partial: 'messages/message', locals: { message: message })
    end

    def message_params
        params.require(:message).permit(:body)
    end

end
  