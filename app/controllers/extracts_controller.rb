class ExtractsController < ApplicationController
  def new 
    @extract = Extract.new
  end 

  def create 
    @extract = Extract.new(extract_params)
    determine_length
    if @extract.save 
      redirect_to @extract, notice: "Extract created successfully!"
    else
      render :new
    end
  end

  private 

  def extract_params
    params.require(:extract).permit(:extract_title, :extract_text)
  end

  def determine_length
    case @extract.extract_text.split(" ").length
    when 0..25
      @extract.extract_length = "Small"
    when 26...50
      @extract.extract_length = "Medium"
    else
      @extract.extract_length = "Large"
    end
  end
end