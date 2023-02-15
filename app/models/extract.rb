class Extract < ApplicationRecord
  validates :extract_text, presence: true
  validates :extract_length, presence: true 
end 