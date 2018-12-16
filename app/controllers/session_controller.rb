class SessionController < ApplicationController
  def login
  end
  
  def create
    user = User.find_by_username(params[:session][:username])
    if(user && user.authenticate(params[:session][:password]))
      session[:user_id] = user.id
      session[:username] = user.username
      flash[:success] = "user logged in successfully"
      redirect_to root_path
    else
      flash[:error] = "you have provided invalid login information"
      render 'login'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "User logged out successfully!!"
    redirect_to login_path
  end
end