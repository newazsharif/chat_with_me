class MessagesChannel < ApplicationCable::Channel
  def subscribed
     stream_from "message_#{params[:chat_id]}"
     
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
