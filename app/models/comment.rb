class Comment < ApplicationRecord
  belongs_to :task
  has_one_attached :file

  validates :body, presence: true
end
