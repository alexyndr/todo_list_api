# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  acts_as_list scope: :project

  validates :name, presence: true
  validate :validate_deadline

  def validate_deadline
    return if deadline.blank?

    errors.add(:deadline, 'must be after the start date') if deadline < Time.now
  end
end
