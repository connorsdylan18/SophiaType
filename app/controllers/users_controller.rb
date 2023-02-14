class UsersController < ApplicationController
  def account_page
    @user = User.find(params[:user_id])
  end

  def results
    @user = User.find(params[:user_id])
    @results = @user.results 
  end
end