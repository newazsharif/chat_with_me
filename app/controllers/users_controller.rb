class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    
    @user = User.new(user_params)
    begin
      @user.transaction do
        @user.save!
        session[:user_id] = @user.id
        session[:username] = @user.username
        flash[:success] = "User created successfully"
        redirect_to root_path
      end
    rescue Exception => e
      
      flash[:error] = e.message
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username,:password)
  end
end
