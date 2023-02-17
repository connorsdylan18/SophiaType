class TypingTestsController < ApplicationController
  def index 
    @mode = params[:mode]
    @size = params[:size]
    if @mode == "quote"
      @extract = Extract.where(extract_length: @size).order("RANDOM()").first
      @text = @extract.extract_text.strip 
    end
    
  end
end