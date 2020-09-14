class User < ApplicationRecord
  has_many :lists

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true


  has_secure_password
end
