class User < ApplicationRecord
  has_secure_password
  has_many :projects, dependent: :destroy

  validates :username, uniqueness: true
  validates :username, :password, presence: true
end
