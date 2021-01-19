class User < ApplicationRecord
  has_secure_password
  has_many :lists
  validates :username, uniqueness: true,  presence: true, length: { minimum: 4 }
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
end

  def user_serializer
    {
      username: username,
      email: email,
      id: id
    }
  end


  # include BCrypt

  # def password
  #   @password_digest ||= Password.new(@password_digest)
  # end

  # def password_digest=(new_password)
  #   @password_digest = Password.create(new_password)
  # end
  

