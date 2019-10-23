# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy

  validates :email, uniqueness: true, presence: true
end
