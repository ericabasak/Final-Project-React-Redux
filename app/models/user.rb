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



