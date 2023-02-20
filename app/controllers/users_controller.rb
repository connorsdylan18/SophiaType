class UsersController < ApplicationController
  before_action :set_current_user

  def account_page
  end

  def results
    @results = @current_user.results 
  end

  # def settings
  #   @user = User.find(params[:user_id])
  # end

  def edit
  end

  def update
    if @current_user.update(user_params)
      @current_user.picture.attach(params[:user][:picture])
      flash[:success] = "Account settings updated successfully!"
      redirect_to user_account_path
    else
      flash[:alert] = "Failed to update account settings!"
      redirect_to user_account_path 
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