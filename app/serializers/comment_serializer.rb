# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :file

  belongs_to :task
end
