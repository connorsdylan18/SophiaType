class User < ApplicationRecord
  has_many :results
  # Creates association between User model and Results table

  has_one_attached :picture 
  validate :picture_content_type 
  validate :picture_size 
  # Creates association between User model and the picture 
  # files stored in active storage. File type and size of file are 
  # validated to ensure normal behaviour when used in views. 

  def picture_content_type 
    if picture.attached? && !picture.content_type.in?(%w(image/jpeg image/png))
      # If the user has a profile picture associated with their 
      # account, throw an error if it is not jpeg or png
      errors.add(:picture, "must be in JPEG or PNG format")
    end
  end 

  def picture_size 
    if picture.attached? && picture.blob.byte_size > 5.megabytes 
      # If the user has a profile picture associated with their 
      # account, throw an error if it is larger than 5MB
      errors.add(:picture, "must be less than 5MB")
    end
  end

  validates :name, length: { maximum: 50 }
  # Specifies the maximum length for the name is 50 characters

  validates :email, presence: true, uniqueness: true, 
    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
  # Email must be present, not already used in the database, and 
  # in the format text@text

  has_secure_password
  # Adds a password and password digest field to the model to temporarily
  # store it as plaintext, then hash this plain text to store as 
  # password_digest in the database
  validates :password, presence: true, 
    format: {
      with: /(?=.*[A-Z])(?=.*\d)/,
      message: "must include at least one uppercase letter and one number"
    },
    length: { minimum: 8, message: "must be at least 8 characters long"}
  # Password must be present, be at least 8 characters long, and contain 
  # a number and an uppercase letter
end
