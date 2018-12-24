class User < ApplicationRecord
  has_many(:messages)
  has_many(:subscriptions)
  has_many(:chats,:through => :subscriptions)
  validates(:username,:presence => true,:length => {:minimum => 3, :maximum => 15})
  has_secure_password
  
  def existing_chat_users
    existing_chat_users = []
    self.chats.each do |chat| 
      existing_chat_users.concat(chat.subscriptions.where.not(:user_id => self.id).map{|s| s.user})
    end
    return existing_chat_users.uniq
  end
  
end
