class TypingTestsController < ApplicationController
  def index 
    @extract = Extract.order("RANDOM()").first
    @text = @extract.attributes["extract_text"] 
  end
end