class HomeController < ApplicationController
  before_action(:require_login)
  
  def index
    @messages = Message.where(:chat_id => nil)
    @message = Message.new
  end
  
  private 
  def require_login
    if(session[:user_id].blank?)
      flash[:error] = "You need permission to view this page"
      redirect_to login_path
    end
  end
end