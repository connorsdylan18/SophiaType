class TypingTestsController < ApplicationController
  def index 
    @mode = params[:mode]
    @size = params[:size]
    if @mode == "quote"
      @extract = Extract.where(extract_length: @size).order("RANDOM()").first
      @text = @extract.extract_text.strip 
    elsif @mode == "words" || @mode == "timed"
      @extract = Extract.find_by(extract_title: "WORDS")
      if @mode == "words"
        case @size 
        when "small"
          @text = @extract.extract_text.split.sample(25).join(" ")
        when "medium"
          @text = @extract.extract_text.split.sample(50).join(" ")
        when "large"
          @text = @extract.extract_text.split.sample(75).join(" ")
        end
      else  
        @text = @extract.extract_text.split.sample(25).join(" ")
      end
    end
  end
end 