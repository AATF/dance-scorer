class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true

  has_many :scores
end
