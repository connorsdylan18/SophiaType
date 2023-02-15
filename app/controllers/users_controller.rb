class UsersController < ApplicationController
  before_action :set_current_user

  def account_page
    @user = @current_user
  end

  def results
    @user = User.find(params[:user_id])
    @results = @user.results 
  end

  def settings
    @user = User.find(params[:user_id])
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    
    if @user.update(user_params)
      puts "********* #{params[:user][:picture]} ***********"
      @user.picture.attach(params[:user][:picture])
      flash[:success] = "Account settings updated successfully!"
      redirect_to user_account_path
    else
      flash[:alert] = "Failed to update account settings!"
      render :edit
    end
  end  

  private 

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end 

  def user_params
    params.require(:user).permit(:name, :email, :picture, :password, :password_confirmation)
  end
end