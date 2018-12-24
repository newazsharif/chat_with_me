class ChatController < ApplicationController
  require 'securerandom'
  before_action :require_user
  
  def index
    @other_chat_users = current_user.existing_chat_users
  end
  
  def create
    @other_user_id = params[:other_user]
    @other_user = User.find(@other_user_id)
    @chat = find_chat(@other_user) || Chat.new(:identifier => SecureRandom.hex)
    
    if(!@chat.persisted?)
      @chat.save
      @chat.subscriptions.create({:user_id => current_user.id})
      @chat.subscriptions.create({:user_id => @other_user_id})
    end
    redirect_to user_chat_path(@current_user,@chat,:other_user_id => @other_user_id)
    
  end
  
  def show
    @other_user = User.find(params[:other_user_id])
    @chat = Chat.find_by_id(params[:id])
    @message = Message.new
  end
  
   
  def find_chat(second_user)
    chats = current_user.chats
    chats.each do |chat|
      chat.subscriptions.each do |s|
        
        if s.user_id == second_user.id
          return chat
        end
      end
    end
    nil
  end
  
 
  
end

