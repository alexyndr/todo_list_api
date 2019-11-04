class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :file

  belongs_to :task
end
