class TypingTestsController < ApplicationController
  def index 
    @size = params[:size]
    @extract = Extract.where(extract_length: @size).order("RANDOM()").first
    @text = @extract.extract_text.strip 
  end
end