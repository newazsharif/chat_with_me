class AddChatIdT0MessagesTable < ActiveRecord::Migration[5.2]
  def change
    add_column(:messages,:chat_id,:integer)
  end
end
