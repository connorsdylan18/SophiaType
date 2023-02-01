class ExtractController < ApplicationController
  def new 
    @extract = Extract.new
  end 
end