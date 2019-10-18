# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  # acts_as_list

  validates :name, presence: true
end
