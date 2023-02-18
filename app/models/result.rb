class Result < ApplicationRecord 
  belongs_to :user
  validates :user, :time, :accuracy, :netWPM, :grossWPM, presence: true 
end