# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy

  validates :email, uniqueness: true
  validates :email, :encrypted_password, presence: true
end
