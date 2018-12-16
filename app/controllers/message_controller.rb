class MessageController < ApplicationController
  def create
    user = current_user.messages.new(message_params)
    if user.save
      # redirect_to root_path
      
      ActionCable.server.broadcast('room_channel',:content => message_params["body"],:username => current_user.username)
    else
      flash[:error] = "message cannot be generated"
    end
  
  end
  
  private
  def message_params
    params.require(:message).permit(:body)
  end
end 