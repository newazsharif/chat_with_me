class MessageController < ApplicationController
  def create
    user = current_user.messages.new(message_params)
    if user.save
      # redirect_to root_path
      # byebug
      if(message_params["chat_id"].blank?)
        
        ActionCable.server.broadcast('room_channel',:content => message_params["body"],:username => current_user.username)
      else
        
        ActionCable.server.broadcast("message_#{message_params[:chat_id]}",:content => message_params["body"],:username => current_user.username)
      end
      
    else
      flash[:error] = "message cannot be generated"
    end
  
  end
  
  
  
  private
  def message_params
    params.require(:message).permit(:body,:chat_id)
  end
end 