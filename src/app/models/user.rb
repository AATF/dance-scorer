class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true

  has_many :scores

  def password_digest(*args)
    if args.empty?
      read_attribute(:password_digest)
    else
      super
    end
  end
end
