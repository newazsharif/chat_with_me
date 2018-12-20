class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    
    if(params[:user][:confirm_password] != user_params[:password])
      
      flash[:error] = "Password and Confirm password have to be same"
      redirect_to new_users_path
    else
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
        redirect_to new_users_path
      end
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username,:password)
  end
end
