class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Successfully logged in"
      redirect_to root_path
    else
      flash[:alert] = "Invalid email or password"
      redirect_to request.referer || root_path 
    end 
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end 