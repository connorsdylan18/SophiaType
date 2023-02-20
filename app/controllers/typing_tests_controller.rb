class TypingTestsController < ApplicationController
  def index 
    @mode = params[:mode]
    @size = params[:size]
    if @mode == "quote"
      @extract = Extract.where(extract_length: @size).where.not(extract_title: "WORDS").order("RANDOM()").first
      @text = @extract.extract_text.strip 
    elsif @mode == "words" || @mode == "timed"
      @extract = Extract.find_by(extract_title: "WORDS", extract_length: "Large")
      if @mode == "words"
        case @size 
        when "Small"
          @text = @extract.extract_text.split.sample(25).join(" ")
        when "Medium"
          @text = @extract.extract_text.split.sample(50).join(" ")
        when "Large"
          @text = @extract.extract_text.split.sample(75).join(" ")
        end
      else  
        @text = @extract.extract_text.split.shuffle.join(" ")
      end
    end
  end
end 