class User < ApplicationRecord
  has_many :results

  has_one_attached :picture 
  validate :picture_content_type 
  validate :picture_size 

  def picture_content_type 
    if picture.attached? && !picture.content_type.in?(%w(image/jpeg image/png))
      errors.add(:picture, "must be in JPEG or PNG format")
    end
  end 

  def picture_size 
    if picture.attached? && picture.blob.byte_size > 5.megabytes 
      errors.add(:picture, "must be less than 5MB")
    end
  end

  validates :name, length: { maximum: 50 }

  validates :email, presence: true, uniqueness: true, 
    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email adress"}

  has_secure_password
  validates :password, presence: true, 
    format: {
      with: /(?=.*[A-Z])(?=.*\d)/,
      message: "must include at least one uppercase letter and one number"
    },
    length: { minimum: 8, message: "must be at least 8 characters long"}
end
