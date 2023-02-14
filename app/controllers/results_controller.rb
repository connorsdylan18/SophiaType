class ResultsController < ApplicationController
  def create
    puts "User ID:", params[:user_id] # Debugging line
    result = Result.new(result_params)
    if result.valid? && result.save
      render json: result, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private 

  def result_params 
    params.require(:result).permit(:user_id, :time, :accuracy, :netWPM, :grossWPM) if params[:result].present? && params[:result][:user_id].present?
  end
end