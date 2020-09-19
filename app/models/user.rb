class User < ApplicationRecord
  has_many :lists

  validates :username, uniqueness: true,  presence: true
  validates :email, uniqueness: true, presence: true

  has_secure_password

  # include BCrypt

  # def password
  #   @password_digest ||= Password.new(@password_digest)
  # end

  # def password_digest=(new_password)
  #   @password_digest = Password.create(new_password)
  # end
  
end
